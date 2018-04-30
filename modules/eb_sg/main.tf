resource "aws_security_group" "eb_sg" {
    name = "${var.name}-${var.environment}-eb"
    description = "Security Group ${var.name}-${var.environment}"
    vpc_id = "${var.vpc_id}"
    tags {
      Name = "${var.name}-${var.environment}-eb"
      environment =  "${var.environment}"
    }
    # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${var.source_cidr_block}"]
  }

  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${var.source_cidr_block}"]
  }
}

output "eb_sg_id" {
  value = "${aws_security_group.eb_sg.id}"
}