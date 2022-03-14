######################################################################
# Terraform Provider
######################################################################

terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.5.0"
        }
    }
}

provider "aws" {
    region = "ap-southeast-2"
    shared_credentials_files = ["/Users/vachananand/.aws/credentials"]
    profile = "VachanAnand"
}