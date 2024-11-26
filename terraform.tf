provider "aws" {
  region = "us-east-1"  # Set your desired region
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with your desired AMI ID
  instance_type = "t2.micro"               # Replace with your desired instance type

  tags = {
    Name = "MyEC2Instance"
  }

  # Associate the EBS volume with the instance
  root_block_device {
    volume_size = 8  # Default size for the root volume, in GB
    volume_type = "gp2"
  }
}

# Create an EBS volume
resource "aws_ebs_volume" "my_ebs_volume" {
  availability_zone = aws_instance.my_instance.availability_zone
  size              = 100  # Size of the EBS volume in GB
  volume_type       = "gp2"  # General Purpose SSD volume type

  tags = {
    Name = "MyEBSVolume"
  }
}

# Attach the EBS volume to the instance
resource "aws_volume_attachment" "my_volume_attachment" {
  device_name = "/dev/sdh"                # You can change the device name
  volume_id   = aws_ebs_volume.my_ebs_volume.id
  instance_id = aws_instance.my_instance.id
}
