resource "aws_instance" "this" {
  count = "${var.count_ec2}"
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id = "${element(var.subnet_ids, count.index)}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  

  user_data              = "${var.user_data}"
  key_name               = "${var.key_name}"
  monitoring             = "${var.monitoring}"
  iam_instance_profile   = "${var.iam_instance_profile}"

  associate_public_ip_address = "${var.associate_public_ip_address}"
  private_ip                  = "${var.private_ip}"
  ipv6_address_count          = "${var.ipv6_address_count}"
  ipv6_addresses              = "${var.ipv6_addresses}"

  ebs_optimized          = "${var.ebs_optimized}"
  volume_tags            = "${var.volume_tags}"
  root_block_device {
    volume_size = "${var.volume_size}"
    volume_type = "${var.volume_type}"
  }

  ebs_block_device       = "${var.ebs_block_device}"
  ephemeral_block_device = "${var.ephemeral_block_device}"

  source_dest_check                    = "${var.source_dest_check}"
  disable_api_termination              = "${var.disable_api_termination}"
  instance_initiated_shutdown_behavior = "${var.instance_initiated_shutdown_behavior}"
  placement_group                      = "${var.placement_group}"
  tenancy = "${var.tenancy}"

  tags {
    Name = "${element(var.instance_names, count.index)}"  
    Env = "${var.environment}"
    Datacenter = "${var.datacenter}"
    Hostname = "${var.datacenter}-${var.environment}-${element(var.instance_names, count.index)}"
    Prometheus_monitoring = "${var.prometheus_monitoring}"
  }

  provisioner "remote-exec" {
    connection {
      host = "${self.private_ip}"
      type = "ssh"
      user = "root"
      private_key = "${file("${var.private_key_path}")}"
    }
    inline = ["echo 'waiting for instance to be up'"]
  }

  provisioner "local-exec" {
    command = <<EOF
      export ANSIBLE_CONFIG="${var.ansible_config_path}" 
      ansible-playbook --private-key ${var.private_key_path} ${var.ansible_hostname_playbook}  --user root -i '${self.private_ip},' -e frg_datacenter='${var.datacenter}' -e frg_env='${var.environment}' -e frg_role='${element(var.instance_names, count.index)}' 
      ansible-playbook --private-key ${var.private_key_path} ${var.ansible_freeipa_playbook}  --user root -i '${self.private_ip},' ${var.ansible_freeipa_vars}

    EOF
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "this" {
  count = "${var.filebeat_install != "false" ? var.count_ec2 : 0}"
  # Changes to the instances that require re-provisioning
  triggers {
    cluster_instance_ids = "${join(",", aws_instance.this.*.id)}"
  }

  provisioner "local-exec" {
    command = <<EOF
      export ANSIBLE_CONFIG="${var.ansible_config_path}"
      ansible-playbook --private-key ${var.private_key_path} ${var.ansible_filebeat_playbook}  --user root -i '${element(aws_instance.this.*.private_ip, count.index)},' -e frg_env='${var.environment}' -e frg_client='internal' -e frg_role='${element(var.instance_names, count.index)}' -e frg_datacenter='${var.datacenter}' -e frg_datacenter_description='aws' -e elastic_master_host='${var.logstash}'
    EOF
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "this_playbook" {
  count = "${var.ansible_playbook_path != "" ? var.count_ec2 : 0}"
  # Changes to the instances that require re-provisioning
  triggers {
    cluster_instance_ids = "${join(",", aws_instance.this.*.id)}"
  }

  provisioner "local-exec" {
    command = <<EOF
      export ANSIBLE_CONFIG="${var.ansible_config_path}"
      ansible-playbook --private-key ${var.private_key_path} ${var.ansible_playbook_path}  --user root -i '${element(aws_instance.this.*.private_ip, count.index)},' ${var.ansible_extra_vars}
    EOF
    interpreter = ["/bin/bash", "-c"]
  }
}
