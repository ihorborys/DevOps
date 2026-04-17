terraform {
  backend "s3" {
    bucket         = "ihorborys-hw9-state-bucket"

    key            = "eks/terraform.tfstate"

    region         = "us-west-2"

    use_lockfile   = true

    encrypt        = true
  }
}