resource "aws_instance" "ec2_instances" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index % length(var.subnet_ids))
  availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))
  associate_public_ip_address = true
  key_name = var.key_name
  tags = {
    Name = "Wordpress_Instance_${count.index + 1}"
  }
}
