#------------------------------------------#
# AWS ASG Configuration
#------------------------------------------#
resource "aws_launch_configuration" "rancher_ha" {
  name_prefix     = "${var.name_prefix}-conf-"
  image_id        = "${lookup(var.amis, var.region)}"
  instance_type   = "${var.instance_type}"
  key_name        = "${var.key_name}"
  security_groups = ["${aws_security_group.rancher_ha.id}"]
  user_data       = "${data.template_file.install.rendered}"

  root_block_device {
    volume_size           = "${var.root_volume_size}"
    delete_on_termination = true
  }

  depends_on = ["aws_rds_cluster_instance.rancher_ha"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "rancher_ha" {
  name_prefix          = "${var.name_prefix}-asg-"
  availability_zones   = "${var.availability_zones}"
  vpc_zone_identifier  = ["${aws_subnet.rancher_ha.*.id}"]
  launch_configuration = "${aws_launch_configuration.rancher_ha.name}"
  load_balancers       = ["${var.name_prefix}-elb-https"]
  health_check_type    = "ELB"
  min_size             = 1
  desired_capacity     = 1
  max_size             = 2

  #protect_from_scale_in = true

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "install" {
  template = <<-EOF
                #cloud-config
                write_files:
                - content: |
                    #!/bin/bash
                    wait-for-docker
                    docker run -d --restart=unless-stopped \
                      -p 8080:8080 -p 9345:9345 \
                      rancher/server:$${rancher_version} \
                      --db-host $${db_host} \
                      --db-name $${db_name} \
                      --db-port $${db_port} \
                      --db-user $${db_user} \
                      --db-pass $${db_pass} \
                      --advertise-address $(ip route get 8.8.8.8 | awk '{print $NF;exit}')
                  path: /etc/rc.local
                  permissions: "0755"
                  owner: root
                EOF

  vars {
    rancher_version = "${var.rancher_version}"
    db_host         = "${aws_rds_cluster.rancher_ha.endpoint}"
    db_name         = "${aws_rds_cluster.rancher_ha.database_name}"
    db_port         = "${aws_rds_cluster.rancher_ha.port}"
    db_user         = "${var.db_user}"
    db_pass         = "${var.db_pass}"
  }
}

resource "aws_security_group" "rancher_ha" {
  name        = "${var.name_prefix}-server"
  description = "Rancher HA Server Ports"
  vpc_id      = "${aws_vpc.rancher_ha.id}"

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "udp"
    self      = true
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port   = 9345
    to_port     = 9345
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
