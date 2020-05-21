# SQS

Creates a SQS queue

usage:

```hcl-terraform
module "my_sqs" {
  source = "github.com/mulecode/terraform.git//module/sqs"
  name = "acme"
  fifo_queue = true
}
```