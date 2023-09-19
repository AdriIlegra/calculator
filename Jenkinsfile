pipeline {
    agent any

    environment {
        CI = 'true'
        ARTIFACTORY_SERVER_ID = 'Calculadora' // Nome do servidor de Artifactory configurado no Jenkins
    }

    stages {
        stage('Connect to Git Repository') {
            steps {
                script {
                    checkout scm
                }
            }
        }
        stage('Gradle test') {
            steps {
                sh './gradlew test'
            }
        }

        stage('Gradle build') {
            steps {
                sh './gradlew build'
            }
        }

        stage('Upload Artifact to JFrog') {
            steps {
                script {
                    def server = Artifactory.server ARTIFACTORY_SERVER_ID
                    def uploadSpec = """{
                        "files": [
                            {
                                "pattern": "build/libs/*.jar",
                                "target": "Calculadora/"
                            }
                        ]
                    }"""
                    server.upload(uploadSpec)
                }
            }
        }
    }

  }