
resource "aws_s3_bucket" "site_bucket" {
    bucket = "${var.site_name}"
    acl = "public-read"
    # policy = "${file("s3-policy.json")}"

    website = {
      index_document = "index.html"
      error_document = "error.html"
    }
}

resource "aws_s3_bucket" "www_redirect_bucket" {
  bucket = "www.${var.site_name}"
  acl = "public-read"
  website = {
    redirect_all_requests_to = "${var.site_name}"
  }
}

# Route53 Domain Name & Resource Records
resource "aws_route53_zone" "site_zone" {
  name = "${var.site_name}"
}

resource "aws_route53_record" "site_ns" {
  zone_id = "${aws_route53_zone.site_zone.zone_id}"
  name = "${var.site_name}"
  type = "NS"
  ttl = "30"
  records = [
    "${aws_route53_zone.site_zone.name_servers.0}",
    "${aws_route53_zone.site_zone.name_servers.1}",
    "${aws_route53_zone.site_zone.name_servers.2}",
    "${aws_route53_zone.site_zone.name_servers.3}"
  ]
}

resource "aws_route53_record" "site_a" {
  zone_id = "${aws_route53_zone.site_zone.zone_id}"
  name = "${var.site_name}."
  type = "A"

  alias = {
    name = "${aws_s3_bucket.site_bucket.website_domain}"
    zone_id = "${aws_s3_bucket.site_bucket.hosted_zone_id}"
    evaluate_target_health = false
  }
}
