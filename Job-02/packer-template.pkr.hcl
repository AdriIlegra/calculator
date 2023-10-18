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
  commit = true
  image  = "${var.image}"
}

build {
  sources = ["source.docker.ubuntu"]

}

  provisioner "shell" {
    inline = [
      "docker login -u ${var.dockerhub_username} -p ${var.dockerhub_password}",
      "docker build -t ${var.dockerhub_username}/calculator .",
      "docker push ${var.dockerhub_username}/calculator"
    ]
  }

  provisioner "ansible" {
    playbook_file = "Job-2/playbook.yml"
  }

  provisioner "file" {
    source      = "calculator.jar"
    destination = "/calculator.jar"
  }

  post-processor "docker-tag" {
    repository = "${var.dockerhub_username}/calculator"
    tag        = "latest"
  }















