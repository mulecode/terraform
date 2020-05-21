variable "name" {}

variable "visibility_timeout_seconds" {
  default = 60
}

variable "fifo_queue" {
  type = bool
  default = false
}

variable "retention_seconds" {
  description = "value in seconds, default value: 14 days"
  default = 1209600
}

variable "maxReceiveCount" {
  default = 5
}