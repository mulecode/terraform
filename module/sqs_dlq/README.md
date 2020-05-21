# SQS

Creates a SQS queue with a dead letter queue

usage:

```hcl-terraform
module "my_sqs" {
  source = "github.com/mulecode/terraform.git//module/sqs_sqs"
  name = "acme"
  fifo_queue = true
  maxReceiveCount = 2
}
```