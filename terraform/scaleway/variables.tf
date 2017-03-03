variable "scw_token" {
  description = "Scaleway Token"
}

variable "scw_organization" {
  description = "Scaleway Organization"
}

variable "scw_region" {
  default     = "par1"
  description = "Scaleway Region"
}

variable "scw_type_manager" {
  default     = "VC1M"
  description = "Scaleway type for Manager"
}

variable "scw_type_node" {
  default     = "VC1M"
  description = "Scaleway type for Node"
}

variable "scw_machine_user" {
  default     = "root"
  description = "User for machine"
}

variable "scw_ssh_key" {
  default     = "~/.ssh/id_rsa"
  description = "Scaleway SSH key"
}

variable "swarm_nodes" {
  default     = 3
  description = "Number of nodes in the cluster"
}

variable "scw_type_glusterfs" {
  default     = "VC1M"
  description = "Scaleway type for GlusterFS"
}

variable "swarm_glusterfs" {
  default     = 3
  description = "Number of glusterfs"
}