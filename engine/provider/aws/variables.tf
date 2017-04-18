variable "aws_access_key" {
  description = "AWS Token"
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
}

variable "aws_region" {
  default     = "eu-west-2"
  description = "AWS Region"
}

variable "aws_ssh_key" {
  description = "ssh key"
}

variable "aws_type_manager" {
  default     = "t2.micro"
  description = "AWS type for manager"
}

variable "aws_type_node" {
  default     = "t2.small"
  description = "AWS type for node"
}

variable "swarm_nodes" {
  default     = 1
  description = "Number of nodes in the cluster"
}

variable "aws_ami" {
  default     = "ami-80c2f6e6"
  description = "Use AMI for VM"
}

variable "swarm_manager" {
  default     = 1
  description = "Number of manager in the cluster"
}