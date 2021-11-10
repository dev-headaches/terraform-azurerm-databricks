variable "dataops_rgname" {
    type = string
}

variable "network_rgname" {
    type = string
}

variable "netsec_rgname" {
    type = string
}

variable "orgname" {
  type        = string
}

variable "enviro" {
  type        = string"
}

variable "prjnum" {
  type        = string
  description = "define the project number for TFstate file ex. 4858"
}

variable "location" {
  type        = string
  description = "location of your resource group"
}

variable "vnet_rgname" {
  type        = string
  description = "the name of the resource group that contains the vnet in which to deploy databricks' subnets"
}

variable "vnet_name" {
  type        = string
  description = "the name of the vnet in which to deploy databricks' subnets"
}

variable "vnet_id" {
    type = string
    description = "the id of the vnet in which to deploy databricks"
}

variable "endpoint_subnet_id" {
    type = string
    description = "the id of the subnet for private endpoints"
}

variable "databricks_public_subnet_name" {
  type        = string
  description = ""
}

variable "databricks_private_subnet_name" {
  type        = string
  description = ""
}

variable "databricks_public_subnet_id" {
  type        = string
  description = ""
}

variable "databricks_private_subnet_id" {
  type        = string
  description = ""
}

variable "private_networking" {
  type        = bool
}