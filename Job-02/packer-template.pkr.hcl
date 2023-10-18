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
  image = "ubuntu:18.04"
  commit = true
}

build {
  sources = ["docker.ubuntu"]
}
  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get install ansible -y",
      "ls -l ./build/libs"  # Adicione o comando ls aqui para listar o conteúdo do diretório
    ]
  }

  provisioner "file" {
    source      = ".build/libs/tema-06-0.0.1-SNAPSHOT.jar"
    destination = "/tema-06-0.0.1-SNAPSHOT.jar"
  }

  provisioner "ansible-local" {
    playbook_file = "./Job-2/playbook.yml"
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "adriananogueira/tema_01_final"
      tag        = "latest"
    }
  }
}
