resource "aws_lb" "private_link_lb" {
  name               = "o11y-privatelink-lb"
  internal           = true
  load_balancer_type = "network"

  subnets = [
    aws.subnet.lb_use2a.id,
    aws.subnet.lb_use2b.id,
    aws.subnet.lb_use2c.id,
  ]

  security_groups = [
    aws.security_group.lb_sg.id,
  ]

  enable_cross_zone_load_balancing                             = true
  enable_deletion_protection                                   = true
  enforce_security_group_inbound_rules_on_private_link_traffic = false

  tags = {
    Name = "o11y-privatelink-lb"
  }
}
