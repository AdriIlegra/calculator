variable "dockerhub_username" {
  type = string
}

variable "dockerhub_password" {
  type = string
}

packer {
  required_plugins {
    docker = {
      source  = "github.com/hashicorp/docker"
      version = ">= 1.0.0"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

source "docker" "ubuntu" {
  image = "ubuntu:latest"
  commit = true
}

build {
  name = "tema-01-final"
  sources = ["docker.ubuntu"]

  provisioner "shell" {
    inline = [
      "docker login -u ${var.dockerhub_username} -p ${var.dockerhub_password}",
      "docker build -t ${var.dockerhub_username}/calculator .",
      "docker push ${var.dockerhub_username}/calculator"
    ]
  }

  provisioner "ansible-local" {
    playbook_file = "playbook.yml"
  }

  provisioner "file" {
    source      = "target/calculator.jar"
    destination = "/calculator.jar"
  }

  post-processor "docker-tag" {
    repository = "your-docker-repo/calculator"
    tag        = "latest"
  }
}









