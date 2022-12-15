terraform {
    backend "s3" {
        bucket = "eb-tf-infrastructure"
        key    = "ebullion-infra"
        region = "ap-south-1"
    }
}
