variable "dockerhub_username" {
  type = string
}

variable "dockerhub_password" {
  type = string
}
variable "ansible_playbook_path" {
  type    = string
  default = "Job-02/playbook.yml" # Substitua com o caminho correto para o seu playbook
}

packer {
  required_plugins {
    docker = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "ubuntu" {
  image  = "ubuntu:20.04"
  commit = true
  changes = [
    "EXPOSE 8085",
    "ENTRYPOINT [\"java\", \"-jar\", \"/tema06-0.0.1-SNAPSHOT.jar\"]"
  ]
}

build {
  name    = "Job-02"
  sources = ["source.docker.ubuntu"]


  provisioner "shell" {
    inline = [
      "docker login -u ${var.dockerhub_username} -p ${var.dockerhub_password}",
      "docker build -t ${var.dockerhub_username}/calculator .",
      "docker push ${var.dockerhub_username}/calculator"
    ]
  }

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get install -y ansible"
    ]
  }


  provisioner "ansible-local" {
    playbook_file = "${var.ansible_playbook_path}"

    post-processors {
      post-processor "docker-tag" {
        repository = "adriananogueira/tema-final-01"
        tags       = ["0.1"]
      }
    }
  }
}