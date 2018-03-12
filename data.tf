data "aws_region" "current" {
  current = true
}

data "template_file" "environment_variables_rails" {
  template = <<-JSON
  [
    {
      "name": "DATABASE_URL",
      "value": "mysql://$${db_user}:$${db_pass}@$${db_host}:$${db_port}/$${db_name}"
    },
    {
      "name": "RAILS_ENV",
      "value": "production"
    },
    {
      "name": "SECRET_KEY_BASE",
      "value": "$${secret_key_base}"
    }
  ]
  JSON

  vars {
    db_host         = "${aws_db_instance.db_instance.address}"
    db_name         = "${aws_db_instance.db_instance.name}"
    db_pass         = "${aws_db_instance.db_instance.password}"
    db_port         = "${aws_db_instance.db_instance.port}"
    db_user         = "${aws_db_instance.db_instance.username}"
    secret_key_base = "${var.secret_key_base}"
  }
}