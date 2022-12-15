############# Variable.tf ##############
variable "domain_name" {
  type = string
}
variable "ssl_arn" {
  type = string
}

############ iam.tf ######################

data "aws_iam_policy_document" "website_policy" {
  statement {
	actions = [
  	"s3:GetObject"
	]
	principals {
  	identifiers = ["*"]
  	type = "AWS"
	}
	resources = [
  	"arn:aws:s3:::${var.domain_name}/*"
	]
  }
}


############ s3.tf #####################

resource "aws_s3_bucket" "website_bucket" {
 bucket = var.domain_name
 acl = "public-read"
policy = data.aws_iam_policy_document.website_policy.json
website {
	index_document = "index.html"
	error_document = "index.html"
  }
}


#resource "aws_s3_bucket_website_configuration" "preprod" {
#  bucket = var.domain_name
#
#  index_document {
#    suffix = "index.html"
#  }
#
#  error_document {
#    key = "error.html"
#  }
#}

resource "aws_s3_bucket_acl" "b_acl" {
  bucket = aws_s3_bucket.website_bucket.id
  acl	= "private"
}


################# cdn.tf ####################

locals {
  s3_origin_id = "myS3Origin"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
	domain_name          	= aws_s3_bucket.website_bucket.bucket_regional_domain_name
	origin_id            	= local.s3_origin_id
  }

  enabled         	= true
  is_ipv6_enabled 	= true
  comment         	= "Some comment"
  default_root_object = "index.html"


  default_cache_behavior {
	allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
	cached_methods   = ["GET", "HEAD"]
	target_origin_id = local.s3_origin_id

	forwarded_values {
  	query_string = false

  	cookies {
    	forward = "none"
  	}
	}

	viewer_protocol_policy = "allow-all"
	min_ttl            	= 0
	default_ttl        	= 2700
	max_ttl            	= 86400
  }

  restrictions {
	geo_restriction {
  	restriction_type = "whitelist"
  	locations    	= ["US", "CA", "GB", "DE", "IN"]
	}
  }

#  tags = {
#	Environment = "production"
#  }

  viewer_certificate {
#	cloudfront_default_certificate = true

     acm_certificate_arn = var.ssl_arn
     ssl_support_method = "sni-only"
     minimum_protocol_version = "TLSv1.2_2021"
  }
  }


#######################################################
