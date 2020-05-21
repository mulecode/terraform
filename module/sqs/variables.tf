variable "name" {}

variable "fifo_queue" {
  type = bool
  default = false
}

variable "visibility_timeout_seconds" {
  default = 60
}