variable "pm_url" {
  description = "proxmoxのAPI URL"
  type        = string
}

variable "pm_user_token_id" {
  description = "ProxmoxのユーザートークンID"
  type        = string
}

variable "pm_token_secret" {
  description = "Proxmoxのユーザートークンシークレット"
  type        = string
}

variable "pm_node_name" {
  description = "proxmoxのノード名"
  type        = string
}

variable "vm_name" {
  description =  "VMの名前"
  type        = string
}

variable "vm_template" {
  description = "VMテンプレート名"
  type        = string
}

variable "vm_bridge" {
  description = "VMのブリッジ名"
  type        = string
}

variable "vm_searchdomain" {
  description = "VMの検索ドメイン名"
  type        = string
}

variable "vm_nameserver" {
  description = "VMのDNSサーバー名"
  type        = string
}

variable "vm_ip" {
  description = "VMの固定IPアドレス"
  type        = string
}

variable "vm_cidr" {
  description = "サブネットマスクのCIDR表記 (例: 24)"
  type        = string
}

variable "vm_gateway" {
  description = "ゲートウェイアドレス"
  type        = string
}

variable "vm_username" {
  description = "VMの初期ユーザー名"
  type        = string
}

variable "vm_password" {
  description = "VMの初期パスワード"
  type        = string
}

variable "ansible_server_password" {
  description = "Ansibleサーバーのパスワード"
  type        = string
}

variable "ansible_server_user" {
  description = "Ansibleサーバーのユーザー名"
  type        = string
}

variable "ssh_private_key_path" {
  description = "SSH秘密鍵のパス"
  type        = string
}

variable "ansible_server_ip"{
  description = "AnsibleサーバーのIPアドレス"
  type        = string
}
