
module "db_servers" {
  for_each = var.db_servers
  source = "./module"
  components_name = each.value["name"]
  env             = var.env
  instance_type   = each.value["instance_type"]
  password        = lookup(each.value, "password", "null" )

}

module "app_servers" {
  depends_on = [ module.db_servers ]
  for_each = var.app_servers
  source = "./module"
  components_name = each.value["name"]
  env             = var.env
  instance_type   = each.value["instance_type"]
  password        = lookup(each.value, "password", "null" )
}




/*resource "aws_instance" "Instance" {
  count = length(var.components)
  ami = data.aws_ami.centos.image_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  tags = {
    Name = var.components[count.index]
  }
}*/
/*
resource "aws_route53_record" "frontend" {
  name    = "frontend-dev.srikaanth62.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.frontend.private_ip]
  zone_id = "Z088180210HCZBPL2XI2M"
}

resource "aws_instance" "mongodb" {
  ami = data.aws_ami.centos.image_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  tags = {
    Name = "mongodb"
  }
}

resource "aws_route53_record" "mongodb" {
  name    = "mongodb-dev.srikaanth62.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.mongodb.private_ip]
  zone_id = "Z088180210HCZBPL2XI2M"
}

resource "aws_instance" "catalogue" {
  ami = data.aws_ami.centos.image_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  tags = {
    Name = "catalogue"
  }
}

resource "aws_route53_record" "catalogue" {
  name    = "catalogue-dev.srikaanth62.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.catalogue.private_ip]
  zone_id = "Z088180210HCZBPL2XI2M"
}

resource "aws_instance" "redis" {
  ami = data.aws_ami.centos.image_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  tags = {
    Name = "redis"
  }
}

resource "aws_route53_record" "redis" {
  name    = "redis-dev.srikaanth62.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.redis.private_ip]
  zone_id = "Z088180210HCZBPL2XI2M"
}

resource "aws_instance" "user" {
  ami = data.aws_ami.centos.image_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  tags = {
    Name = "user"
  }
}

resource "aws_route53_record" "user" {
  name    = "user-dev.srikaanth62.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.user.private_ip]
  zone_id = "Z088180210HCZBPL2XI2M"
}

resource "aws_instance" "cart" {
  ami = data.aws_ami.centos.image_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  tags = {
    Name = "cart"
  }
}

resource "aws_route53_record" "cart" {
  name    = "cart-dev.srikaanth62.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.cart.private_ip]
  zone_id = "Z088180210HCZBPL2XI2M"
}

resource "aws_instance" "mysql" {
  ami = data.aws_ami.centos.image_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  tags = {
    Name = "mysql"
  }
}

resource "aws_route53_record" "mysql" {
  name    = "mysql-dev.srikaanth62.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.mysql.private_ip]
  zone_id = "Z088180210HCZBPL2XI2M"
}

resource "aws_instance" "shipping" {
  ami = data.aws_ami.centos.image_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  tags = {
    Name = "shipping"
  }
}

resource "aws_route53_record" "shipping" {
  name    = "shipping-dev.srikaanth62.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.shipping.private_ip]
  zone_id = "Z088180210HCZBPL2XI2M"
}

resource "aws_instance" "rabbitmq" {
  ami = data.aws_ami.centos.image_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  tags = {
    Name = "rabbitmq"
  }
}

resource "aws_route53_record" "rabbitmq" {
  name    = "rabbitmq-dev.srikaanth62.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.rabbitmq.private_ip]
  zone_id = "Z088180210HCZBPL2XI2M"
}

resource "aws_instance" "payment" {
  ami = data.aws_ami.centos.image_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  tags = {
    Name = "payment"
  }
}

resource "aws_route53_record" "payment" {
  name    = "payment-dev.srikaanth62.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.payment.private_ip]
  zone_id = "Z088180210HCZBPL2XI2M"
}

resource "aws_instance" "dispatch" {
  ami = data.aws_ami.centos.image_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  tags = {
    Name = "dispatch"
  }
}

resource "aws_route53_record" "dispatch" {
  name    = "dispatch-dev.srikaanth62.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.dispatch.private_ip]
  zone_id = "Z088180210HCZBPL2XI2M"
} */