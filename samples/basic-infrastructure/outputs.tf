output "vpc_id" {
  value = module.vpc_public.vpc_id
}

output "public_subnets" {
  value = module.vpc_public.public_subnets
}

output "cluster_arn" {
  value = module.fargate_cluster.cluster_arn
}

output "cluster_id" {
  value = module.fargate_cluster.cluster_id
}

output "zoneId" {
  value = data.aws_route53_zone.selected.id
}

output "zoneIdName" {
  value = data.aws_route53_zone.selected.name
}

output "lb_id" {
  value = module.public_lb.lb_id
}

output "lb_arn" {
  value = module.public_lb.lb_arn
}

output "lb_name" {
  value = module.public_lb.lb_name
}

output "acm_certificate_id" {
  value = aws_acm_certificate.cert.id
  sensitive = true
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.cert.arn
  sensitive = true
}