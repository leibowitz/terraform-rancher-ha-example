#------------------------------------------#
# AWS EFS Configuration
#------------------------------------------#
resource "aws_efs_file_system" "rancher_ha" {
  creation_token = "rancher_ha_efs"
}

resource "aws_security_group" "rancher_ha_efs" {
  name        = "${var.name_prefix}-efs-default"
  description = "Rancher HA EFS Security Group"
  vpc_id      = "${aws_vpc.rancher_ha.id}"
}

resource "aws_security_group_rule" "allow_efs" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.rancher_ha_efs.id}"
  security_group_id        = "${aws_security_group.rancher_ha_efs.id}"
}

resource "aws_efs_mount_target" "rancher_ha" {
  count           = "${length(var.availability_zones)}"
  file_system_id  = "${aws_efs_file_system.rancher_ha.id}"
  security_groups = ["${aws_security_group.rancher_ha_efs.id}"]
  subnet_id       = "${element(aws_subnet.rancher_ha.*.id, count.index)}"
}
