pipeline {
    agent any

    environment {
        CI = 'true'
        ARTIFACTORY_SERVER_ID = 'Calculadora' // Nome do servidor de Artifactory configurado no Jenkins
    }

    tools {
        gradle 'Gradle 4.4.1'
        jdk 'Java 11'
    }

    stages {
        stage('Connect to Git Repository') {
            steps {
                script {
                    checkout scm
                }
            }
        }

        stage('Gradle clean') {
            steps {
                sh './gradlew clean'
            }
        }


        stage('Upload Artifact to JFrog') {
            steps {
                script {
                    def server = Artifactory.server ARTIFACTORY_SERVER_ID
                    def uploadSpec = """{
                        "files": [
                            {
                                "pattern": "build/libs/calculadora.0.0.1-SNAPSHOT.jar",
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