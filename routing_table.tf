##############################################################################
# Routing Table
##############################################################################

resource ibm_is_vpc_routing_table hub_vpc_routing_table {
    vpc  = module.hub_vpc.vpc_id
    name = "${var.unique_id}-routing-table"
}

##############################################################################


##############################################################################
# Rules to route traffic to Spoke VPC Subnet
##############################################################################

resource ibm_is_vpc_routing_table_route hub_vpc_egress {
    count         = length(keys(var.hub_vpc_cidr_blocks))
    vpc           = module.hub_vpc.vpc_id
    routing_table = ibm_is_vpc_routing_table.hub_vpc_routing_table.routing_table
    zone          = "${var.ibm_region}-${count.index + 1}"
    name          = "${var.unique_id}-egress-zone-${count.index + 1}"
    destination   = module.spoke_vpc.subnet_zone_list[0].cidr
    action        = "delegate_vpc"
    next_hop      = ""
}

##############################################################################

