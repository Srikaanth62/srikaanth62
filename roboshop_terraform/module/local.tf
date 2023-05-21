locals {
  name = var.env != "" ? "${var.components_name}-${var.env}" : var.components_name
  db_commands = [
    "rm -rf Roboshop-Project-Shell",
    "git clone https://github.com/Srikaanth62/Roboshop-Project-Shell",
    "cd Roboshop-Project-Shell",
    "sudo bash ${var.components_name}.sh ${var.password}"
  ]
  app_commands = [
    "sudo labauto ansible",
    "ansible-pull -i localhost, -U https://github.com/Srikaanth62/roboshop-ansible roboshop.yml -e env=${var.env} -e role_name=${var.components_name}"
  ]
  db_tags = {
    Name = "${var.components_name}-${var.env}"
  }
  app_tags = {
    Name      = "${var.components_name}-${var.env}"
    Monitor   = "true"
    component = var.components_name
    env       = var.env
  }
}