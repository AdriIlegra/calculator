variables {

  USERNAME   = "adriananogueira"
  PASSWORD   = "123Mudar@"
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
        "docker login -u ${var.USERNAME} -p ${var.PASSWORD}",
        "docker build -t ${var.USERNAME}/calculator .",
        "docker push ${var.USERNAME}/calculator"
        ]
    }
}
