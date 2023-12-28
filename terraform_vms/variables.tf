###cloud vars

variable "image_name" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex compute image name"
}

variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "zone1a" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "zone1b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "zone1d" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "priv1_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "priv2_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "pub1_cidr" {
  type        = list(string)
  default     = ["10.10.0.0/16"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "pub2_cidr" {
  type        = list(string)
  default     = ["10.11.0.0/16"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "pub3_cidr" {
  type        = list(string)
  default     = ["10.12.0.0/16"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "vpc_name" {
  type        = string
  default     = "netology-cloudvpc"
  description = "VPC network & subnet name"
}

variable "privatenet1" {
  type        = string
  default     = "privnet01"
  description = "VPC network & subnet name"
}

variable "privatenet2" {
  type        = string
  default     = "privnet02"
  description = "VPC network & subnet name"
}
variable "privatenet3" {
  type        = string
  default     = "privnet03"
  description = "VPC network & subnet name"
}

variable "pubnet1" {
  type        = string
  default     = "pubnet01"
  description = "VPC network & subnet name"
}

variable "pubnet2" {
  type        = string
  default     = "pubnet02"
  description = "VPC network & subnet name"
}
variable "pubnet3" {
  type        = string
  default     = "pubnet03"
  description = "VPC network & subnet name"
}
variable "sg_name" {
  type        = string
  default     = "sgmysql"
  description = "SG name"
}
