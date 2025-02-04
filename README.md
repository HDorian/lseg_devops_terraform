Terraform 3-Tier Architecture Module

This Terraform module sets up a highly modular, best-practices 3-tier architecture in AWS, including:

Compute Layer (Auto Scaling Groups, Load Balancers)

Network Layer (VPC, Subnets, Security Groups)

Database Layer (DynamoDB with best-practices configurations)

📌 Features

Full modularity – Separate modules for compute, networking, and database

Security-first approach – Uses best practices for IAM, networking, and encryption

Highly configurable – All values managed via terraform.tfvars

Pre-commit hooks – Enforces Terraform linting, validation, and security scans

Production-ready – Based on industry best practices

📖 Usage

1️⃣ **Define the Configuration in **terraform.tfvars

aws_region = "us-east-1"

compute_config = {
  ami_id            = "ami-12345678"
  instance_type     = "t3.micro"
  asg_min_size      = 1
  asg_max_size      = 5
  asg_desired_size  = 2
  security_groups   = ["sg-12345678"]
  subnets           = ["subnet-123", "subnet-456"]
  tg_name           = "app-tg"
  tg_port           = 80
  tg_protocol       = "HTTP"
  vpc_id            = "vpc-abcdefg123456789"
  listener_port     = 80
  listener_protocol = "HTTP"
  lb_name           = "app-load-balancer"
  lb_internal       = false
  lb_type           = "application"
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
}

2️⃣ Deploy the Infrastructure

git clone https://github.com/your-org/terraform-3tier.git
cd terraform-3tier

terraform init -upgrade
terraform apply -var-file="terraform.tfvars"

3️⃣ Destroy the Infrastructure

terraform destroy -var-file="terraform.tfvars"

📜 Inputs & Outputs

🔹 Inputs

Name

Type

Description

compute_config

object

Configuration for compute resources

network_config

object

Configuration for networking resources

dynamodb_config

object

Configuration for DynamoDB database

🔹 Outputs

Name

Description

compute_asg_name

Name of the Auto Scaling Group

compute_lb_arn

ARN of the Load Balancer

network_vpc_id

ID of the created VPC

dynamodb_table_name

Name of the DynamoDB table

dynamodb_table_arn

ARN of the DynamoDB table

🛠️ Development & Contributing

🔹 Pre-Commit Hooks

This repository enforces Terraform best practices via pre-commit hooks.
To install:

pre-commit install
pre-commit run --all-files

🔹 Running Tests with Terratest

go test -v test/

📝 License

This project is licensed under the MIT License. See LICENSE for details.

🙌 Contributing

We welcome contributions! Please follow the guidelines in CONTRIBUTING.md.
<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.0)

- <a name="requirement_aws"></a> [aws](#requirement\_aws) (~> 5.72.1)

## Providers

No providers.

## Modules

The following Modules are called:

### <a name="module_compute"></a> [compute](#module\_compute)

Source: ./modules/compute

Version:

### <a name="module_database"></a> [database](#module\_database)

Source: ./modules/database

Version:

### <a name="module_network"></a> [network](#module\_network)

Source: ./modules/network

Version:

## Resources

No resources.

## Required Inputs

The following input variables are required:

### <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region)

Description: AWS Region to deploy resources

Type: `string`

### <a name="input_compute_config"></a> [compute\_config](#input\_compute\_config)

Description: Configuration for compute resources

Type:

```hcl
object({
    ami_id            = string
    instance_type     = string
    asg_min_size      = number
    asg_max_size      = number
    asg_desired_size  = number
    security_groups   = list(string)
    subnets           = list(string)
    tg_name             = string
    tg_port             = number
    tg_protocol         = string
    vpc_id              = string
    listener_port       = number
    listener_protocol   = string
    lb_name             = string
    lb_internal         = bool
    lb_type             = string
  })
```

### <a name="input_dynamodb_config"></a> [dynamodb\_config](#input\_dynamodb\_config)

Description: DynamoDB table configuration

Type:

```hcl
object({
    name                     = string
    billing_mode             = string
    hash_key                 = string
    range_key                = optional(string)
    attributes               = list(map(string))
    read_capacity            = optional(number)
    write_capacity           = optional(number)
    global_secondary_indexes = optional(list(object({
      name            = string
      hash_key        = string
      range_key       = optional(string)
      projection_type = string
      read_capacity   = optional(number)
      write_capacity  = optional(number)
    })), [])
    kms_master_key_id        = optional(string)
  })
```

### <a name="input_network_config"></a> [network\_config](#input\_network\_config)

Description: Configuration for network resources

Type:

```hcl
object({
    vpc_cidr        = string
    vpc_name        = string
    public_subnets  = list(map(string))
    private_subnets = list(map(string))
  })
```

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_aws_region"></a> [aws\_region](#output\_aws\_region)

Description: AWS region used for deployment
<!-- END_TF_DOCS -->