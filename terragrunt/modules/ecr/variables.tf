variable "env" {}
variable "common_tags" {}
variable "aws_ecr_repository_names" {
  type    = list(string)
  default = []
}
variable "aws_ecr_trusted_principals" {
  type        = list(string)
  default     = []
  description = "List of AWS principals to grant Push and Pull permissions"
}