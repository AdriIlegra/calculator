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
builders: [
  {
    "type": "docker",
    "image": "ubuntu:20.04",
    "commit": true,
    "author": "damico.lipe@gmail.com",
    "changes": [
      "EXPOSE 8080",
      "CMD [\"apache-tomcat-10.0.12/bin/catalina.sh\", \"run\"]"
    ]
  }
]

provisioners: [
{
"type": "shell",
"inline": [
"apt-get update",
"apt-get install ansible -y"
]
},
{
"type": "ansible-local",
"playbook_file": "/Job-02/playbook.yml"
},
{
},
{
"type": "file",
"source":  "{{user `tomcat_dir`}}",
"destination": "/apache-tomcat-10.0.12/webapps/calculator-app.war"
}
]
provisioner "shell" {
  inline = [
    "docker login -u ${var.dockerhub_username} -p ${var.dockerhub_password}",
    "docker build -t ${var.dockerhub_username}/calculator .",
    "docker push ${var.dockerhub_username}/calculator"
  ]
}