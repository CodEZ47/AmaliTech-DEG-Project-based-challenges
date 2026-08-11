resource "aws_vpc" "vela_main" {
  cidr_block = var.vela_main_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
}



resource "aws_subnet" "vela_public" {
  vpc_id = aws_vpc.vela_main.id
  count = length(var.vela_public_subnet_cidrs)

  cidr_block = var.vela_public_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "vela_private" {
  vpc_id = aws_vpc.vela_main.id
  count = length(var.vela_private_subnet_cidrs)

  cidr_block = var.vela_private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

}

resource "aws_internet_gateway" "vela_internet_gate" {
    vpc_id = aws_vpc.vela_main.id
}

resource "aws_route_table" "public"{
    vpc_id = aws_vpc.vela_main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.vela_internet_gate.id
    }
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.vela_public)
  subnet_id = aws_subnet.vela_public[count.index].id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table" "private"{
    vpc_id = aws_vpc.vela_main.id
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.vela_private)
  subnet_id = aws_subnet.vela_private[count.index].id
  route_table_id = aws_route_table.private.id
}


