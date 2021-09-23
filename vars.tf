variable "IDENTIFIER" {
  default = "react-app"
}
variable "VPC_ID" {
  default = "vpc-c64808a2"
}
variable "AMI_ID" {
  default = "ami-0d058fe428540cd89"
}
variable "SSH_USER" {
  default = "ubuntu"
}
variable "SUBNET_ID" {
  default = "subnet-47898123"
}
variable "INSTANCE_TYPE" {
  default = "t3a.medium"
}
variable "region" {
  default = "ap-southeast-1"
}

variable "SSH_KEY_PRIVATE" {
  default = "dummy.pem"
}
variable "access_key" {}
variable "secret_key" {}
