terraform-srinivas-project/
├── backend/ # S3 bucket and DynamoDB for remote backend
│ ├── s3-dynamodb.tf
│ └── variables.tf
├── network/ # VPC, Subnet, Internet Gateway
│ ├── vpc.tf
│ └── variables.tf
├── compute/ # EC2 instance
│ ├── ec2.tf
│ └── variables.tf
└── main.tf # Remote backend configuration

Summary

Remote state management with S3 + DynamoDB.

Modular infrastructure with backend, network, and compute.

EC2 setup automated via user-data.

Flexible and reusable via variables.

Accessible message without SSH, showing end-to-end Terraform deployment.
