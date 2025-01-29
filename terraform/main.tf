########
# ECR
########

resource "aws_ecr_repository" "web" {
  name                 = "${local.app_name}_web_ecr-repository"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "api" {
  name                 = "${local.app_name}_api_ecr-repository"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

########
# ECS
########

resource "aws_ecs_cluster" "this" {
  name = "${local.app_name}-ecs-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${local.app_name}_ecs-task-definition"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn           = aws_iam_role.ecs_task_execution_role.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name = "${local.app_name}-container"
      image = "public.ecr.aws/nginx/nginx:perl"
      essential = true
    }
  ])
}

resource "aws_ecs_service" "this" {
  name = "${local.app_name}_ecs-service"
  cluster = aws_ecs_cluster.this.arn
  task_definition = aws_ecs_task_definition.this.arn
  desired_count = 1
  launch_type = "FARGATE"

  network_configuration {
    assign_public_ip = true
    subnets = data.aws_subnets.default.ids
    security_groups = [data.aws_security_group.default.id]
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${local.app_name}_ecs-task-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

########
# VPC
########

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

########
# Security Group
########

data "aws_security_group" "default" {
  name = "launch-wizard-14"
}
