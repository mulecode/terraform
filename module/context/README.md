# Context

Retrieves all variables from a plan in S3


Sample:

```hcl-terraform
module "context" {
  source = "github.com/mulecode/terraform.git//module/context"
  region = "eu-west-2"
}
```

### Properties:

#### state_file_path

S3 Key values for the state file on s3

default value: 
```
infrastructure/main.tfstate
```

#### state_bucket_name

bucket name where terraform saves state files

default value:
```
terraform-<current_account_id>
```

Note: current_account_id will always be 
appended at the end of the bucket name 