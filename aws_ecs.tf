resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.app_base_name}"
}

resource "aws_ecs_service" "ecs_service" {
  cluster                            = "${aws_ecs_cluster.ecs_cluster.id}"
  deployment_minimum_healthy_percent = 50
  desired_count                      = "${var.aws_ecs_service_desired_count_rails}"
  iam_role                           = "${aws_iam_role.ecs.arn}"
  name                               = "${var.app_base_name}_rails"
  load_balancer {
    container_name   = "${var.app_base_name}_rails"
    container_port   = "3000"
    target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
  }
  task_definition = "${aws_ecs_task_definition.ecs_task_definition.arn}"
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  container_definitions = <<-JSON
  [
    {
      "executionRoleArn": null,
      "containerDefinitions": [
        {
          "dnsSearchDomains": null,
          "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
              "awslogs-group": "${var.rails_awslogs_group}",
              "awslogs-region": "${var.rails_awslogs_region}",
              "awslogs-stream-prefix": "${var.rails_awslogs_stream_prefix}"
            }
          },
          "entryPoint": null,
          "portMappings": [
            {
              "hostPort": 3000,
              "protocol": "tcp",
              "containerPort": 3000
            }
          ],
          "command": [],
          "linuxParameters": null,
          "cpu": 300,
          "environment": [
            {
              "name": "MYSQL_DATABASE",
              "value": "${var.mysql_database}"
            },
            {
              "name": "MYSQL_USERNAME",
              "value": "${var.mysql_username}"
            },
            {
              "name": "MYSQL_PASSWORD",
              "value": "${var.mysql_password}"
            },
            {
              "name": "MYSQL_HOST",
              "value": "${var.mysql_host}"
            },
            {
              "name": "SECRET_KEY_BASE",
              "value": "${var.secret_key_base}"
            }
          ],
          "ulimits": null,
          "dnsServers": null,
          "mountPoints": [],
          "workingDirectory": null,
          "dockerSecurityOptions": null,
          "memory": null,
          "memoryReservation": 300,
          "volumesFrom": [],
          "image": "${var.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/${var.app_base_name}_nginx_dev",
          "disableNetworking": null,
          "healthCheck": null,
          "essential": true,
          "links": [],
          "hostname": null,
          "extraHosts": null,
          "user": null,
          "readonlyRootFilesystem": null,
          "dockerLabels": null,
          "privileged": null,
          "name": "${var.app_base_name}-rails-dev"
        },
        {
          "dnsSearchDomains": null,
          "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
              "awslogs-group": "${var.nginx_awslogs_group}",
              "awslogs-region": "${var.nginx_awslogs_region}",
              "awslogs-stream-prefix": "${var.nginx_awslogs_stream_prefix}"
            }
          },
          "entryPoint": null,
          "portMappings": [
            {
              "hostPort": 80,
              "protocol": "tcp",
              "containerPort": 80
            }
          ],
          "command": null,
          "linuxParameters": null,
          "cpu": 300,
          "environment": [],
          "ulimits": null,
          "dnsServers": null,
          "mountPoints": [],
          "workingDirectory": null,
          "dockerSecurityOptions": null,
          "memory": null,
          "memoryReservation": 300,
          "volumesFrom": [],
          "image": "${var.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/${var.app_base_name}_nginx_dev",
          "disableNetworking": null,
          "healthCheck": null,
          "essential": true,
          "links": [
            "${var.app_base_name}-rails-dev:app"
          ],
          "hostname": null,
          "extraHosts": null,
          "user": null,
          "readonlyRootFilesystem": null,
          "dockerLabels": null,
          "privileged": null,
          "name": "${var.app_base_name}-nginx-dev"
        }
      ],
      "memory": "600",
      "taskRoleArn": "arn:aws:iam::${var.account_id}:role/ecsTaskExecutionRole",
      "family": "${var.app_base_name}_rails",
      "requiresCompatibilities": null,
      "networkMode": "bridge",
      "cpu": "600",
      "volumes": [],
      "placementConstraints": []
    }
  ]
  JSON
}

