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

variable "aws_type_node" {
  default     = "t2.micro"
  description = "Scaleway type for Node"
}

variable "aws_key_name" {
  default     = ""
  description = "AWS key name"
}

variable "aws_ami" {
  default     = ""
  description = "AWS ami"
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
