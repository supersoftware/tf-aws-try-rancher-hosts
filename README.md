Terraform to add autoscaling aws hosts to try.rancher.com.


# Configure
Variables which could be configured are as below.

( **It is best not to keep credentials in version control** )

* aws_access_key
  * AWS Access Key
* aws_secret_key
  * AWS Secret Key
* aws_region
  * AWS Region(default = "ap-northeast-1")
* rancher_environment_id
  * Rancher Environment ID
* rancher_environment_access_key
  * Rancher Environment Access Key
* rancher_environment_secret_key
  * Rancher Environment Secret Key
* cluster_name
  * The name of the cluster. Used for host labels, etc.
* target_vpc_id
  * The ID of the VPC in which the hosts would be placed.
* rancheros_ami
  * AMI of the RancherOS(default = "ami-29e4e44e")
  * Search for the newest AMI [here](https://github.com/rancher/os)
* ec2_key_name
  * The EC2 key name to use when creating it
* spot_price
  * Spot instance request price
* asg_min_size
  * The min size of the auto scaling group(default = "2")
* asg_max_size
  * The max size of the auto scaling group(default = "2")
* asg_desired_capacity
  * The desired capacity of the auto scaling group(default = "2")
* vpc_private_subnet_ids
  * The private subnet id to use inside the VPC


## Sample

```
aws_access_key = "<AWS_ACCESS_KEY>"

aws_secret_key = "<AWS_SECRET_KEY>"

rancher_environment_id = "<ENVIRONMENT_ID>"

rancher_environment_access_key = "<ENVIRONMENT_ACCESS_KEY>"

rancher_environment_secret_key = "<ENVIRONMENT_SECRET_KEY>"

cluster_name = "tryranchercluster"

target_vpc_id = "vpc-xxxxxxxx"

ec2_key_name = "<YOUR_KEYPAIR_NAME>"

spot_price = "0.1"

asg_min_size = "5"

asg_max_size = "5"

asg_desired_capacity = "5"

vpc_private_subnet_ids = "subnet-xxxxxxxx"
```