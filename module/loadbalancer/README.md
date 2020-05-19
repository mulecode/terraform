# Application loadbalancer

Creates an application load balancer to be used within ecs applications

### Sample:

```hcl-terraform
module "public_lb" {
  source = "github.com/mulecode/terraform.git//module/loadbalancer"
  name = "mulecode-lb"
  zoneId = data.aws_route53_zone.selected.id
  subnets = [subnets]
  vpc_id = "VPC ID"
  domainName = "foo.yourdomain.com"
}
```

### Properties:

#### zoneId

id of existing route 53 zone id

example:

```hcl-terraform
data "aws_route53_zone" "selected" {
  name = "mulecode.com"
}
```

#### domainName

load balance domain name to be added on the selected route 53

example:

```hcl-terraform
domainName = "services.mulecode.com"
``` 