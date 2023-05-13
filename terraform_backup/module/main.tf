resource "aws_instance" "instance" {
  ami = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  tags = {
    Name = local.name
  }
}

resource "null_resource" "provisioner" {
  count = var.provisioner ? 1 : 0
  depends_on = [ aws_instance.instance, aws_route53_record.records ]
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }

    inline = [
      "sudo rm -rf Roboshop-Project-Shell",
      "git clone https://github.com/Srikaanth62/Roboshop-Project-Shell.git",
      "cd Roboshop-Project-Shelll",
      "sudo bash ${var.components_name}.sh ${var.password}"
    ]
  }
}

resource "aws_route53_record" "records" {
  name    = "${var.components_name}-dev.srikaanth62.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
  zone_id = "Z088180210HCZBPL2XI2M"
}


