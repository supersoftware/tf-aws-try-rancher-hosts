# Configure the AWS Provider
provider "aws" {
  # DO NOT WRITE YOUR KEYS INSIDE HERE AND DON'T MANAGE THEM INSIDE GIT
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

module "staging_cluster" {
  # Import the module from Github
  # It's probably better to fork or clone this repo if you intend to use in production
  # so any future changes dont mess up your existing infrastructure.
  source = "github.com/supersoftware/tf-modules//aws-rancher-hosts"

  # Add Rancher server details
  server_hostname = "try.rancher.com"

  # Rancher environment
  # In your Rancher server, create an environment and an API keypair. You can have
  # multiple host clusters per environment if necessary. Instances will be labelled
  # with the cluster name so you can differentiate between multiple clusters.
  environment_id = "${var.rancher_environment_id}"

  environment_access_key = "${var.rancher_environment_access_key}"
  environment_secret_key = "${var.rancher_environment_secret_key}"

  # Name your cluster and provide the autoscaling group name and security group id.
  cluster_name = "${var.cluster_name}"

  cluster_autoscaling_group_name = "${aws_autoscaling_group.cluster_autoscale_group.id}"

  cluster_instance_security_group_id = "${aws_security_group.cluster_instance_sg.id}"
}

# Cluster instance security group
resource "aws_security_group" "cluster_instance_sg" {
  name        = "Rancher-Cluster-Instances"
  description = "Rules for connected Rancher host machines. These are the hosts that run containers placed on the cluster."
  vpc_id      = "${var.target_vpc_id}"

  lifecycle {
    create_before_destroy = true
  }
}

# Autoscaling launch configuration
resource "aws_launch_configuration" "cluster_launch_conf" {
  name = "Launch-Config"

  # Amazon linux, ap-northeast-1
  image_id = "${var.rancheros_ami}"

  # No public ip when instances are placed in private subnets.
  associate_public_ip_address = false

  # Security groups
  security_groups = [
    "${aws_security_group.cluster_instance_sg.id}",
  ]

  # Key
  key_name = "${var.ec2_key_name}"

  # Add rendered userdata template
  user_data = "${module.staging_cluster.host_user_data}"

  # Misc
  spot_price        = "${var.spot_price}"
  instance_type     = "m4.large"
  enable_monitoring = true

  lifecycle {
    create_before_destroy = true
  }
}

# Autoscaling group
resource "aws_autoscaling_group" "cluster_autoscale_group" {
  name                      = "Cluster-ASG"
  launch_configuration      = "${aws_launch_configuration.cluster_launch_conf.name}"
  min_size                  = "${var.asg_min_size}"
  max_size                  = "${var.asg_max_size}"
  desired_capacity          = "${var.asg_desired_capacity}"
  health_check_grace_period = 180
  health_check_type         = "EC2"
  force_delete              = false
  termination_policies      = ["OldestInstance"]

  # Target subnets
  vpc_zone_identifier = ["${var.vpc_private_subnet_ids}"]

  tag {
    key                 = "Name"
    value               = "Test-Rancher-Cluster-Instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
