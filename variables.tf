variable count_ec2 {
  description = "Number of instance to create"
  default = 1
}

variable "region" {
    default = "eu-central-1"
} 

variable "ami" {
    
}
variable "private_key_path" { 
    description = "Path to your private key"
    default = "~/.ssh/id_rsa"
}

variable "instance_type" {
    description = "The type of instance to start"
}

variable "subnet_ids" {
    description = "The list of VPC Subnet IDs to launch in"
    type = "list"
}

variable instance_names {
    description = "The instance names must reflect the role of the instances. ex: kube-worker"
    type = "list"
}

variable environment {
    description = "prod, infra, dev or stage..."
}

variable datacenter {
    default = "frkt"
}

variable prometheus_monitoring  {
    description = "Set to false to disable monitoring"
    default = "true"
}

variable ansible_config_path {
    default = "../../../ansible/ansible.cfg"
}

variable ansible_hostname_playbook {
    default = "../../../ansible/playbooks/hostname_ubuntu.yml"
}
variable ansible_freeipa_playbook {
    default = "../../../ansible/playbooks/freeipa-client.yml"
}

variable ansible_freeipa_vars {
    default = "-e freeipa_server_ip='172.32.0.231' -e freeipa_server_hostname='frkt-infra-ipa-005.internal.n0q.eu' -e freeipa_server_ip_2='172.32.1.98' -e freeipa_server_hostname_2='frkt-infra-ipa-006.internal.n0q.eu' -e freeipa_client_hostname='internal.n0q.eu' -e freeipa_server_hostname='frkt-infra-ipa-005.internal.n0q.eu' -e internal_domain='internal.n0q.eu' -e realm='INTERNAL.N0Q.EU' -e principal_user='admin' -e principal_user_password='Lemondenesuffitpas!1'"
}

variable filebeat_install {
    default = "true"
}
variable ansible_filebeat_playbook {
    default = "../../../ansible/playbooks/filebeat.yml"
}
variable logstash {
    default="frkt-infra-logstash-kibana-8765.internal.n0q.eu"
}

variable ansible_playbook_path {
    default = ""
}

variable ansible_extra_vars {
    description = "Set up extra parameters for ansible. Example: -e frg_role='prometheus-alertmanager' -e service='prometheus'"
    default = ""
}

variable "placement_group" {
  description = "The Placement Group to start the instance in"
  default     = ""
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  default     = "default"
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = false
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance" # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
  default     = ""
}

variable "key_name" {
  description = "The key name to use for the instance"
  default     = ""
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = "list"
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  default     = false
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  default     = ""
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
  default     = true
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = ""
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  default     = ""
}

variable "ipv6_address_count" {
  description = "A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet."
  default     = 0
}

variable "ipv6_addresses" {
  description = "Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
  default     = []
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  default     = {}
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  default     = []
}

variable "volume_size" {
    description = "Size of the volume in GB"
    default = 8
} 

variable "volume_type" {
    description = "Volume type"
    default = "standard"
} 

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  default     = []
}

variable "ephemeral_block_device" {
  description = "Customize Ephemeral (also known as Instance Store) volumes on the instance"
  default     = []
}

variable "network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  default     = []
}

variable "cpu_credits" {
  description = "The credit option for CPU usage (unlimited or standard)"
  default     = "standard"
}