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
    "ENTRYPOINT [\"java\", \"-jar\", \"/Tema-final-1-0.0.1-SNAPSHOT.jar\"]"
  ]
}

build {
  name = "job-2"
  sources = ["source.docker.ubuntu"]

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get install -y ansible"
    ]
  }


  provisioner "ansible-local" {
    playbook_file = "./job-2/playbook.yml"
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "brunnadocker/tema-final-1"
      tags       = ["0.1"]
    }
  }
}