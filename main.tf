terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
  access_key = "<Put your access key here>"
  secret_key = "<Put your secret key here>"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-website-test-bucket-for-opentofu"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

}

# Upload an object
resource "aws_s3_bucket_object" "example" {

  bucket = "my-website-test-bucket-for-opentofu"
  key    = "index.html"
  source = "/home/avaseaa/Documents/SRE/index.html"

}



resource "aws_s3_bucket_policy" "example" {
  bucket = "my-website-test-bucket-for-opentofu"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-website-test-bucket-for-opentofu/*"
    }
  ]
}
POLICY
}

#resource "aws_s3_bucket_public_access_block" "example" {
#  bucket = "my-website-test-bucket-for-opentofu"

#  block_public_acls   = false
#  block_public_policy = false
#}
