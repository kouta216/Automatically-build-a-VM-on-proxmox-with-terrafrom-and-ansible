# provider設定
pm_url            = "[proxmoxのAPI URL]"
pm_user_token_id  = "[proxmoxのユーザー名]@[認証方式]![proxmoxのユーザートークンID]"
pm_token_secret   = "[proxmoxのユーザートークンシークレット]"

# vm設定
pm_node_name     = "[proxmoxのノード名]"
vm_name = "[VMの名前]"
vm_template = "[VMテンプレート名]"
vm_bridge  = "[VMのブリッジ名]"
vm_searchdomain = "[VMの検索ドメイン名]"
vm_nameserver = "[VMのDNSサーバーのIPアドレス]"
vm_ip      = "[VMの固定IPアドレス]"
vm_cidr    = "[サブネットマスクのCIDR表記 (例: 24)]"
vm_gateway = "[ゲートウェイアドレス]"
vm_username = "[VMのユーザー名]"
vm_password = "[VMのパスワード]"

# ansible設定
ansible_server_password = "[ansibleサーバーのパスワード]"
ansible_server_user = "[ansibleサーバーのユーザー名]"
ssh_private_key_path = "[実行ホストのSSH秘密鍵のパス]"
ansible_server_ip = "[ansibleサーバーのIPアドレス]"