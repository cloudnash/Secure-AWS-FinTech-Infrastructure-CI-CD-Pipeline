resource "aws_ecs_cluster" "fintech_cluster" {
  name = "fintech-payroll-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled" # Monitoring and logging
  }
}

resource "aws_ecs_task_definition" "app_task" {
  family                   = "fintech-payroll-app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "fintech-api"
      image     = "nginx:latest" # Placeholder for your actual ECR image
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}
