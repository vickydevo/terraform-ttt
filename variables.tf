variable "vpc_cidr_block" {
  description = "vpc_cidr_block"
  default     = "10.0.0.0/16"
}
variable "subnet_cidr_blocks" {
  description = "cidr block range"
  #default     = "10.0.1.0/16"
  type        = list(string)
}
variable "azs" {
     type        = list(string)
}
variable "date" {}
variable "env" {}