resource "aws_security_group" "new-sg" {
  vpc_id = aws_vpc.new-aws_vpc.id

  name = "${var.prefix}-sg"

  tags = {
    Name = "${var.prefix}-sg"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
}