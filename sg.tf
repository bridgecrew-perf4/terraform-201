data "http" "myip" {
  url = "http://ipv4bot.whatismyipaddress.com"
}

resource "aws_security_group" "ob1-management" {
  name        = "ob1-management"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }

   ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ob1-management"
  }
}

resource "aws_security_group" "ob1-production" {
  name        = "ob1-production"
  description = "Allow Prod inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Prod traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }

   ingress {
    description = "Prod traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ob1-production"
  }
}

resource "aws_security_group" "ob1-consul" {
  name        = "ob1-consul"
  description = "Allow consul inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "To Consul"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.2.0/24"]
  }

   ingress {
    description = "To Consul"
    from_port   = 8300
    to_port     = 8301
    protocol    = "tcp"
    cidr_blocks = ["10.0.2.0/24"]
  }

    ingress {
    description = "To Consul"
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = ["10.0.2.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ob1-consul"
  }
}

resource "aws_security_group" "ob1-nginx" {
  name        = "ob1-nginx"
  description = "Allow nginx inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "To NGINX"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.3.0/24"]
  }

   ingress {
    description = "To NGINX"
    from_port   = 8300
    to_port     = 8301
    protocol    = "tcp"
    cidr_blocks = ["10.0.3.0/24"]
  }

    ingress {
    description = "To NGINX"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.3.0/24"]
  }

    ingress {
    description = "To NGINX"
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["10.0.3.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ob1-nginx"
  }
}