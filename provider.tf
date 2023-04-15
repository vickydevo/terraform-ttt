terraform {
  # STABLE versions of terraform 1.4.5/1.3.9/12.9/1.1.9
  required_version = "1.4.4"
  backend "s3" {
    bucket = "terraform-ec2-state-file"
    key    = "ec2/state-tfstate"
    region = "us-east-1"

  }

}




provider "aws" {
  # access_key = "AKIA3N2LTYY4XXXXXXXXX"
  # secret_key = "XXXXXXXXXXXXXYmGRkc7iRMiiCS5lPCT"
  shared_config_files      = ["C:/Users/VIGNAN/.aws/config"]
  shared_credentials_files = ["C:/Users/VIGNAN/.aws/credentials"]
  profile                  = "default"
}
