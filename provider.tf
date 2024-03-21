terraform {

  cloud {
    organization = "muhammadnourman"

    workspaces {
      name = "tf_nginx"
    }
  }

  required_providers {
    dns = {
      source = "hashicorp/dns"
      version = "3.4.0"
    }
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }

}

variable "tsig_key" {
    type = string
    sensitive = true
}

provider "dns" {
  update {
    server          = "192.168.88.4"
    key_name        = "tsig-key."
    key_algorithm   = "hmac-sha256"
    key_secret      = var.tsig_key
  }
}

variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_token_id" {
    type = string
    sensitive = true
}

variable "proxmox_api_token_secret" {
    type = string
    sensitive = true
}

provider "proxmox" {
    pm_api_url = var.proxmox_api_url
    pm_api_token_id = var.proxmox_api_token_id
    pm_api_token_secret = var.proxmox_api_token_secret
    pm_tls_insecure = true
}