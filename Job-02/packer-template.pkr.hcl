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

  source "docker" "ubuntu" {
    type  = "docker-image"
    image = "ubuntu:18.04"
    pull  = true
  }

  build {
    name    = "my-docker-image"
    sources = ["docker.ubuntu"]

    provisioner "shell" {
      inline = [
        "docker login -u ${var.dockerhub_username} -p ${var.dockerhub_password}",
        "docker build -t ${var.dockerhub_username}/calculator .",
        "docker push ${var.dockerhub_username}/calculator"
      ]
    }

    provisioner "ansible-local" {
      playbook_file = "/Job-2/playbook.yml"
    }


  }
}
