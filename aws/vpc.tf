resource "aws_vpc" "new-aws_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "fullcycle-vpc"
  }
}