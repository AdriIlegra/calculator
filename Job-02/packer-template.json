{
  "variables": {
    "docker_hub_username": "",
    "docker_hub_password": ""
  },
    "builders": [
        {
        "type": "docker",
        "image": "ubuntu",
        "commit": true,
          "changes" : [
        "EXPOSE 8888",
        "ENTRYPOINT  [\"sh\", \"-c\", \"java ${JAVA_OPTS} -jar /var/lib/jetty/webapps/ROOT.jar\"]"
      ]
    }
    ],

    "build": [
        {
            "name": "calculator",
            "source": "calculator.jar"

        },
        {
            "type": "shell",
            "script": ["./job-02/install-ansible.sh"
            ]
        },
        {
            "type": "ansible-local",
            "playbook_file": "./job-02/playbook.yml"
        }
    ],

    "provisioners": [
            {
                "type": "shell",
                "inline": [
                    "echo 'Hello World'"
                ]
            }
        ]
}
