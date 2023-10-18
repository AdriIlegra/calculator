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
  image  = "ubuntu:18.04"
  commit = "true"
  changes = [
    "EXPOSE 8888",
    "ENTRYPOINT  [\"java\", \"-jar\", \"calculator.jar\"]"
  ]
}
build {
  name    = "my-docker-image"
  sources = ["docker.ubuntu"]

  provisioner "ansible" {
    script = "/Job-02/playbook.yml"
  }

  provisioner "file" {
    source      = "calculator.jar"
    destination = "/calculator.jar"
  }
  post-processor "docker-push" {
    login          = true
    login_username = "${var.USERNAME}"
    login_password = "${var.PASSWORD}"
  }
}


