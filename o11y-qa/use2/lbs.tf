resource "aws_lb" "private_link_lb" {
  provider           = aws.use2
  name               = "o11y-lb"
  internal           = false
  load_balancer_type = "network"

  subnets = [
    aws_subnet.service_provider_use2_az1.id,
    aws_subnet.service_provider_use2_az2.id,
    aws_subnet.service_provider_use2_az3.id,
  ]

  security_groups = [
    aws_security_group.lb_sg.id,
  ]

  enable_cross_zone_load_balancing                             = true
  enable_deletion_protection                                   = false
  enforce_security_group_inbound_rules_on_private_link_traffic = "off"

  tags = {
    Name = "o11y-lb"
  }
}

output "private_link_lb_arn" {
  value = aws_lb.private_link_lb.arn
}
