pipeline {
    agent any

    environment {
        CI = 'true'
        ARTIFACTORY_SERVER_ID = 'calculadora' // Nome do servidor de Artifactory configurado no Jenkins
    }

    stages {
        stage('Connect to Git Repository') {
            steps {
                script {
                    checkout scm
                }
            }
        }


        stage('Upload Artifact to JFrog') {
            steps {
                script {
                    def server =ARTIFACTORY_SERVER_ID
                    def uploadSpec = """{
                        "files": [
                            {
                                "pattern": "target/*.jar",  // Arquivo que será enviado para o Artifactory
                                "target": "libs-release-local/"
                            }
                        ]
                    }"""
                    server.upload(uploadSpec)
                }
            }
        }
    }

  }