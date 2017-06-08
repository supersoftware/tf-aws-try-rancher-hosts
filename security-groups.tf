# Cluster instance security group
resource "aws_security_group" "cluster_instance_sg" {
  name        = "Rancher-Cluster-Instances"
  description = "Rules for connected Rancher host machines. These are the hosts that run containers placed on the cluster."
  vpc_id      = "${var.target_vpc_id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "kafka_ingress" {
  security_group_id = "${aws_security_group.cluster_instance_sg.id}"
  type              = "ingress"
  from_port         = 9010
  to_port           = 9010
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "minio_ingress" {
  security_group_id = "${aws_security_group.cluster_instance_sg.id}"
  type              = "ingress"
  from_port         = 9000
  to_port           = 9000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "minio_egress" {
  security_group_id = "${aws_security_group.cluster_instance_sg.id}"
  type              = "egress"
  from_port         = 9000
  to_port           = 9000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "graphana_ingress" {
  security_group_id = "${aws_security_group.cluster_instance_sg.id}"
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "prometheus_ingress" {
  security_group_id = "${aws_security_group.cluster_instance_sg.id}"
  type              = "ingress"
  from_port         = 9090
  to_port           = 9090
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "spark_driver_ingress" {
  security_group_id = "${aws_security_group.cluster_instance_sg.id}"
  type              = "ingress"
  from_port         = 8888
  to_port           = 8888
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "spark_master_ingress" {
  security_group_id = "${aws_security_group.cluster_instance_sg.id}"
  type              = "ingress"
  from_port         = 4040
  to_port           = 4040
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "spark_zeppelin_ingress" {
  security_group_id = "${aws_security_group.cluster_instance_sg.id}"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "http_ingress" {
  security_group_id = "${aws_security_group.cluster_instance_sg.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  lifecycle {
    create_before_destroy = true
  }
}
