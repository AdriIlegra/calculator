pipeline {
    agent any
    stages {
        stage('Checkout from Git') {
            steps {
                git branch: 'master', url: https://github.com/AdriIlegra/calculator.git'
            }
        }
        stage('Upload Artifact to JFrog') {
            steps {
                script {
                    def server = Artifactory.server 'ARTIFACTORY_SERVER_ID' // Use the server name you configured
                    def uploadSpec = """{
                        "files": [
                            {
                                "pattern": "target/*.jar",  // File to be uploaded to Artifactory
                                "target": "libs-release-local/"
                            }
                        ]
                    }"""
                    server.upload spec: uploadSpec
                }
            }
        }
    }
}
