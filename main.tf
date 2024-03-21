resource "dns_a_record_set" "nginx" {
    zone = "home.tomputjef.com."
    name = "nginx"
    addresses = [ "192.168.88.70" ]
    ttl = 3600
}

resource "proxmox_vm_qemu" "nginx" {
    target_node = "kaby-pve"
    vmid = "170"
    name = "nginx.home.tomputjef.com"
    qemu_os	= "l26"
    agent = "1"
    tags = ""
    automatic_reboot = "false"
    onboot = "false"
    boot = "order=virtio0"
    clone = "ubuntu-2204"
    cores = "1"
    sockets = "1"
    cpu = "host"    
    memory = "2048"
    network {
        bridge = "vmbr0"
        model  = "virtio"
    }
    disks {
        virtio {
            virtio0 {
                disk {
                    storage = "local-lvm"
                    discard = "true"
                    iothread = "true"
                    size = "20"
                }
            }
        }
    }
    scsihw = "virtio-scsi-single"
    os_type = "cloud-init"
    ipconfig0 = "ip=192.168.88.70/24,gw=192.168.88.254"
    nameserver = "192.168.88.4"
    searchdomain = "home.tomputjef.com"
    cloudinit_cdrom_storage = "local-lvm"
    ciuser = "nourman"
    cicustom = "vendor=local:snippets/ci-custom.yaml" # /var/lib/vz/snippets/ci-custom.yaml
    sshkeys = <<EOF
    ssh-rsa AAAA
    EOF
}