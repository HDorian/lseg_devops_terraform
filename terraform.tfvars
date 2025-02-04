aws_region = "us-east-1"

compute_config = {
  ami_id            = "ami-12345678"
  instance_type     = "t3.micro"
  asg_min_size      = 1
  asg_max_size      = 5
  asg_desired_size  = 2
  security_groups   = ["sg-12345678"]
  subnets           = ["subnet-123", "subnet-456"]
}


network_config = {
  vpc_cidr        = "10.0.0.0/16"
  vpc_name        = "my-vpc"
  public_subnets  = [{ cidr = "10.0.1.0/24", az = "us-east-1a" }, { cidr = "10.0.2.0/24", az = "us-east-1b" }]
  private_subnets = [{ cidr = "10.0.3.0/24", az = "us-east-1a" }, { cidr = "10.0.4.0/24", az = "us-east-1b" }]
}

dynamodb_config = {
  name               = "my-table"
  billing_mode       = "PAY_PER_REQUEST"
  hash_key           = "id"
  attributes         = [{ name = "id", type = "S" }]
  read_capacity      = 5
  write_capacity     = 5
  #kms_key_arn = "arn:aws:kms:us-west-2:123456789012:key/example-key-id"
}
