packer {
  required_plugins {
    docker = {
      version = ">= 0.4.0"
      source  = "github.com/hashicorp/docker"
    }
    ansible = {
      version = ">= 0.0.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "docker" "example" {
  image = "ubuntu"
}

build {
  sources = ["source.docker.example"]
  provisioner "shell" {
    inline = [
      "echo 'Hello, world!'",
    ]
  }
}
