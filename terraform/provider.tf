provider "aws" {

  region  = "us-east-1"

  # Pinned version due to issue described in more detail here: https://github.com/aws-samples/eks-workshop-v2/issues/538
  version = "4.67.0"
}