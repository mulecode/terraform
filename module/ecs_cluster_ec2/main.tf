resource "aws_ecs_cluster" "main" {
  name = var.name

  setting {
    name = "containerInsights"
    value = var.containerInsights
  }
}

resource "aws_security_group" "main" {
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "main" {
  image_id = var.image_id
  iam_instance_profile = aws_iam_instance_profile.ecs_instance.name
  security_groups = [
    aws_security_group.main.id]
  user_data = "#!/bin/bash\necho ECS_CLUSTER=${var.name} >> /etc/ecs/ecs.config"
  associate_public_ip_address = true
  instance_type = var.instance_type
}

resource "aws_autoscaling_group" "failure_analysis_ecs_asg" {
  name = "${var.name}-autoscalingGroup"
  vpc_zone_identifier = var.subnet_ids
  launch_configuration = aws_launch_configuration.main.name
  desired_capacity = var.desired_capacity
  min_size = var.min_size
  max_size = var.max_size
  health_check_grace_period = 300
  health_check_type = "EC2"
}
