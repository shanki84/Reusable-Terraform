#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "demo" {
  cidr_block = "${var.cidr-vpc}"
  enable_dns_hostnames = true

  tags = "${
    map(
      "Name", "${var.env}-VPC-MS",
      "kubernetes.io/cluster/${var.env}-EKS-MS", "shared",
    )
  }"
}

resource "aws_subnet" "demo" {
  count = 3

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "${var.cidr-subnet}.${count.index*64}/26"
  vpc_id            = "${aws_vpc.demo.id}"

  tags = "${
    map(
      "Name", "${var.env}-SG-MS-Subnet-0${count.index+1}",
      "kubernetes.io/cluster/${var.env}-EKS-MS", "shared",
    )
  }"
}

resource "aws_internet_gateway" "demo" {
  vpc_id = "${aws_vpc.demo.id}"

  tags = {
    Name = "${var.env}-SG-MS-GW"
  }
}

resource "aws_route_table" "demo" {
  vpc_id = "${aws_vpc.demo.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demo.id}"
  }
}

resource "aws_route_table_association" "demo" {
  count = 3

  subnet_id      = "${aws_subnet.demo.*.id[count.index]}"
  route_table_id = "${aws_route_table.demo.id}"

}
