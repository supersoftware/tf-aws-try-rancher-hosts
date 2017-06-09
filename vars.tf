variable "aws_access_key" {
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
}

variable "aws_region" {
  description = "AWS Region"
  default     = "ap-northeast-1"
}

variable "rancher_environment_id" {
  description = "Rancher Environment ID"
}

variable "rancher_environment_access_key" {
  description = "Rancher Environment Access Key"
}

variable "rancher_environment_secret_key" {
  description = "Rancher Environment Secret Key"
}

variable "cluster_name" {
  description = "The name of the cluster. Used for host labels, etc."
}

variable "target_vpc_id" {
  description = "The ID of the VPC in which the hosts would be placed."
}

variable "rancheros_ami" {
  description = "AMI of the RancherOS"
  default     = "ami-29e4e44e"
}

variable "ec2_key_name" {
  description = "The EC2 key name to use when creating it"
}

variable "spot_price" {
  description = "Spot instance request price"
  default     = "0.03"
}

variable "asg_min_size" {
  description = "The min size of the auto scaling group"
  default     = "2"
}

variable "asg_max_size" {
  description = "The max size of the auto scaling group"
  default     = "2"
}

variable "asg_desired_capacity" {
  description = "The desired capacity of the auto scaling group"
  default     = "2"
}

variable "vpc_private_subnet_ids" {
  description = "The private subnet id to use inside the VPC"
}
