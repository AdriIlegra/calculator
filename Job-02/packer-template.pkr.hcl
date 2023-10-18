# packer-template.pkr.hcl

variables {
  dockerhub_username    = ""
  dockerhub_password    = ""
  ansible_playbook_path = "./Job-02/playbook.yml"
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
      "sudo apt-get update",
      "sudo pt-get install -y ansible"
    ]
  }
  provisioner "ansible-local" {
    playbook_file = "${var.ansible_playbook_path}"  # Especifique o caminho do playbook Ansible
  }
}