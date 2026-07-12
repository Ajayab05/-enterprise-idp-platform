terraform {

  backend "s3" {

    bucket = "enterprise-idp-lab-tfstate-076124125794"
    key    = "lab/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "enterprise-idp-lab-tf-lock"

    encrypt = true

  }

}
