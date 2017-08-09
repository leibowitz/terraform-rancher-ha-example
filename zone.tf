resource "aws_route53_record" "rancher-ha" {
  zone_id = "${var.zone_id}"
  name    = "${var.record_name}"
  type    = "A"

  alias {
    name                   = "${aws_elb.rancher_ha_https.dns_name}"
    zone_id                   = "${aws_elb.rancher_ha_https.zone_id}"
    evaluate_target_health = false
  }
}
