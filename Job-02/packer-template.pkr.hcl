
variable "dockerhub_username" {
  type    = string
}

variable "dockerhub_password" {
  type    = string
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
  name = "calculator"

  sources = ["source.docker.ubuntu"]

  provisioner "shell" {
    script = "./job-02/install-ansible.sh"
  }

  provisioner "ansible-local" {
    playbook_file = "./job-02/common.yml"
  }

  provisioner "file" {
    source      = "Calculator-1.0-all.jar"
    destination = "/calculator.jar"
  }

  provisioner "shell" {
    inline = [
      "docker login -u ${var.dockerhub_username} -p ${var.dockerhub_password}",
      "docker build -t ${var.dockerhub_username}/calculator .",
      "docker push ${var.dockerhub_username}/calculator"
    ]
  }
}