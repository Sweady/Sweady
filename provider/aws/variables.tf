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

variable "aws_key_name" {
  default     = ""
  description = "AWS key name"
}

variable "aws_type_manager" {
  default     = "t2.micro"
  description = "AWS type for manager"
}

variable "aws_type_node" {
  default     = "t2.micro"
  description = "AWS type for node"
}

variable "aws_type_glusterfs" {
  default     = "t2.micro"
  description = "AWS type for glusterfs"
}

variable "aws_ami_user" {
  default     = "root"
  description = "Ami user connection"
}

variable "aws_ssh_key" {
  default     = "~/.ssh/id_rsa"
  description = "AWS SSH key"
}

variable "swarm_nodes" {
  default     = 1
  description = "Number of nodes in the cluster"
}

variable "swarm_glusterfs" {
  default     = 4
  description = "Number of glusterfs in the cluster"
}

variable "aws_ami" {
  default = "ami-80c2f6e6"
  description = "Use AMI for VM"
}