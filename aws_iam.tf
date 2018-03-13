resource "aws_iam_role" "ec2" {
  assume_role_policy = <<-JSON
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        }
      }
    ]
  }
  JSON

  name = "${var.app_base_name}_ec2"
}

resource "aws_iam_role" "ecs" {
  assume_role_policy = <<-JSON
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": "ecs.amazonaws.com"
        }
      }
    ]
  }
  JSON

  name = "${var.app_base_name}_ecs"
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_instance" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  role       = "${aws_iam_role.ec2.id}"
}


resource "aws_iam_role_policy_attachment" "ecs_service" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
  role       = "${aws_iam_role.ecs.id}"
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "${var.app_base_name}"
  role = "${aws_iam_role.ec2.name}"
}