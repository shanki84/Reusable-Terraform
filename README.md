# ReusableTerraform
A Terraform module to create an Elastic Kubernetes (EKS) cluster and associated worker instances on AWS.
Terraform code to build Prod / Sand / Test environment is available on GitLab

git clone https://github.com/shanki84/Reusable-Terraform.git
cd terraform

You need to run the following commands to create the resources with Terraform:

# terraform init
# terraform plan
# terraform apply

Amazon EKS-Optimized AMI
The Amazon EKS-optimized AMI is built on top of Amazon Linux 2, and is configured to serve as the base image for Amazon EKS worker nodes. The AMI is configured to work with Amazon EKS out of the box, and it includes Docker, kubelet, and the AWS IAM Authenticator.

https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html


What resources are created

1.  VPC
2.  Internet Gateway (IGW)
3.  Public and Private Subnets
4.  Security Groups, Route Tables and Route Table Associations
5.  IAM roles, instance profiles and policies
6.  An EKS Cluster
7.  Autoscaling group and Launch Configuration
8.  Worker Nodes in a private Subnet
9.  The ConfigMap required to register Nodes with EKS
10. KUBECONFIG file to authenticate kubectl using the heptio authenticator aws binary


Remote Terraform Module
You can use the modules main.tf as a remote source which holds the variables calling vars.tf to build the respective environment :

module "my_ecs" {
  source                = "../modules/source"
  region                = "${var.region}"
  env                   = "${var.env}"
  cidr-vpc              = "${var.cidr-vpc}"
  cidr-subnet           = "${var.cidr-subnet}"
  image-id              = "${var.image-id}"
  number_of_instances   = "${var.number_of_instances}"
  instance-type         = "${var.instance-type}"
  desired-capacity      = "${var.desired-capacity}"
  max_size              = "${var.max_size}"
  min_size              = "${var.min_size }"
  }


Managing Cluster Authentication (using Jump Host)
1. Installing kubectl
2. Installing aws-iam-authenticator
3. Create a kubeconfig for Amazon EKS
4. Managing Users or IAM Roles for your Cluster

Setup kubectl
Setup your KUBECONFIG

terraform output kubeconfig > ~/.kube/eks-cluster
export KUBECONFIG=~/.kube/eks-cluster
Authorize worker nodes
Get the config from terraform output, and save it to a yaml file:

terraform output config-map > config-map-aws-auth.yaml
Apply the config map to EKS:

kubectl apply -f config-map-aws-auth.yaml
You can verify the worker nodes are joining the cluster

kubectl get nodes --watch
Cleaning up
You can destroy this cluster entirely by running:

terraform plan -destroy
terraform destroy  --force
