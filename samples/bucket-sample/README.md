# S3 bucket state

Creates a simple s3 bucket used to store terraform plan states

Bucket name:

```
terraform-<aws_account_id>
```


Init

```shell script
terraform init -backend-config="./backend_config/dev.tfvars"
```

Plan

```shell script
terraform plan -var-file "./env_vars/dev.tfvars" --out ./build.plan
```

Apply

```shell script
terraform apply ./build.plan
```