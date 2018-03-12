resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.app_base_name}"
}

resource "aws_ecs_service" "ecs_service" {
  cluster                            = "${aws_ecs_cluster.ecs_cluster.id}"
  deployment_minimum_healthy_percent = 50
  desired_count                      = "${var.aws_ecs_service_desired_count_rails}"
  launch_type                        = "EC2"
  name                               = "${var.app_base_name}_rails"
  load_balancer {
    container_name   = "${var.app_base_name}_rails"
    container_port   = "5000"
    target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
  }
  network_configuration {
    subnets = [
      "${aws_subnet.vpc_main-public-subnet1.id}",
      "${aws_subnet.vpc_main-public-subnet2.id}"
    ]
    security_groups = [
      "${aws_security_group.alb_sg.id}",
      "${aws_security_group.app_sg.id}"
    ]
//    assign_public_ip = "ENABLED"
  }
  task_definition = "${aws_ecs_task_definition.ecs_task_definition.arn}"
}


resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.app_base_name}_rails"
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  execution_role_arn       = "arn:aws:iam::${var.account_id}:role/ecsTaskExecutionRole"
  cpu                      = 256
  memory                   = 512

  container_definitions = <<-JSON
  [
    {
      "environment": ${data.template_file.environment_variables_rails.rendered},
      "image": "ssig33/fastladder-postgres",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${var.app_base_name}",
          "awslogs-region": "${data.aws_region.current.name}",
          "awslogs-stream-prefix": "rails"
        }
      },
      "cpu": 256,
      "memory": 512,
      "networkMode": "awsvpc",
      "name": "${var.app_base_name}_rails",
      "portMappings": [
        {
          "containerPort": 5000,
          "protocol": "tcp"
        }
      ]
    }
  ]
  JSON
}

resource "aws_ecs_task_definition" "rails_db_setup" {
  family                   = "${var.app_base_name}_rails_db_setup"
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  execution_role_arn       = "arn:aws:iam::${var.account_id}:role/ecsTaskExecutionRole"
  cpu                      = 256
  memory                   = 512

  container_definitions = <<-JSON
  [
    {
      "command": ["bin/rake", "db:create", "db:migrate"],
      "environment": ${data.template_file.environment_variables_rails.rendered},
      "image": "ssig33/fastladder-postgres",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${var.app_base_name}",
          "awslogs-region": "${data.aws_region.current.name}",
          "awslogs-stream-prefix": "rails"
        }
      },
      "cpu": 256,
      "memory": 512,
      "networkMode": "awsvpc",
      "name": "${var.app_base_name}_rails"
    }
  ]
  JSON
}
