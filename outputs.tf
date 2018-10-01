locals {
  this_id                           = "${compact(concat(aws_instance.this.*.id, list("")))}"
  this_availability_zone            = "${compact(concat(aws_instance.this.*.availability_zone, list("")))}"
  this_key_name                     = "${compact(concat(aws_instance.this.*.key_name, list("")))}"
  this_public_dns                   = "${compact(concat(aws_instance.this.*.public_dns, list("")))}"
  this_public_ip                    = "${compact(concat(aws_instance.this.*.public_ip, list("")))}"
  this_network_interface_id         = "${compact(concat(aws_instance.this.*.network_interface_id, list("")))}"
  this_primary_network_interface_id = "${compact(concat(aws_instance.this.*.primary_network_interface_id, list("")))}"
  this_private_dns                  = "${compact(concat(aws_instance.this.*.private_dns, list("")))}"
  this_private_ip                   = "${compact(concat(aws_instance.this.*.private_ip, list("")))}"
  this_security_groups              = "${compact(concat(flatten(aws_instance.this.*.security_groups), list("")))}"
  this_vpc_security_group_ids       = "${compact(concat(flatten(aws_instance.this.*.vpc_security_group_ids), list("")))}"
  this_subnet_id                    = "${compact(concat(aws_instance.this.*.subnet_id, list("")))}"
  this_tags                         = "${flatten(aws_instance.this.*.tags)}"
  this_placement_group              = "${compact(concat(aws_instance.this.*.placement_group, list("")))}"
}

output "id" {
    description = "The instance ID"
    value = ["${local.this_id}"]
} 

output "availability_zone" {
    description = "The availability zone of the instance"
    value = ["${local.this_availability_zone}"]   
}    

output "placement_group" {
    description = "The placement group of the instance"
    value = ["${local.this_placement_group}"]
}

output "key_name" {
    description = "The key name of the instance"
    value = ["${local.this_key_name}"]
}

output "public_dns" {
    description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
    value = ["${local.this_public_dns}"]
}

output "public_ip" {
    description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use public_ip, as this field will change after the EIP is attached"
    value = ["${local.this_public_ip}"]
}


output "network_interface_id" {
    description = "The ID of the network interface that was created with the instance."
    value = ["${local.this_network_interface_id}"]
}

output "primary_network_interface_id" {
    description = "The ID of the instance's primary network interface."
    value = ["${local.this_primary_network_interface_id}"]
}

output "private_dns" {
    description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
    value = ["${local.this_private_dns}"]
}

output "private_ip" {
    description = "The private IP address assigned to the instance"
    value = ["${local.this_private_ip}"]
}

output "security_groups" {
    description = "The associated security groups"
    value = ["${local.this_security_groups}"]
}

output "vpc_security_group_ids" {
    description = "The associated security groups in non-default VPC"
    value = ["${local.this_vpc_security_group_ids}"]
}

output "subnet_id" {
    description = "The VPC subnet ID"
    value = ["${local.this_subnet_id}"]
}


output "tags" {
  description = "List of tags of instances"
  value       = ["${local.this_tags}"]
}