provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "EC2_instance" {
  ami           = var.aws_image_id
  instance_type = var.aws_instance_type
  key_name      = var.aws_key_name

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 20
    volume_type = "gp3"
    tags = {
      Name = "RootVolume"
    }
  }

  tags = {
    Name = "Demo Instance"
  }

}

