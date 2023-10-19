# packer-template.pkr.hcl
variables {
  dockerhub_username    = "adriananogueira"
  dockerhub_password    = "123Mudar@"
  ansible_playbook_path = "./Job-02/playbook.yml"
  dockerhub_credentials = "docker_hub_credentials" # Substitua pelo valor correto
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
  image   = "ubuntu:20.04"
  commit  = true
  changes = [
    "EXPOSE 8085",
    "ENTRYPOINT [\"java\", \"-jar\", \"/Tema-final-1-0.0.1-SNAPSHOT.jar\"]"
  ]
}

build {
  name    = "job-2"
  sources = ["source.docker.ubuntu"]

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get install -y sudo",  # Instala o sudo
      "sudo apt-get install -y ansible"
    ]
  }

  provisioner "ansible-local" {
    playbook_file = "${var.ansible_playbook_path}"
  }
}
