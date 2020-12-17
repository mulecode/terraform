output "cluster_arn" {
  value = aws_ecs_cluster.main.arn
}

output "cluster_id" {
  value = aws_ecs_cluster.main.name
}

output "execution_role_arn" {
  value = aws_iam_role.main.arn
}
