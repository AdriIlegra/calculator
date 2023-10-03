pipeline {
    agent any
    stages {
        stage('Checkout from Git') {
            steps {
                script {
                    // Configure the Git tool installation (replace 'GitToolName' with the actual Git tool name)
                    def gitTool = tool name: 'GitToolName', type: 'hudson.plugins.git.GitTool'
                    withEnv(["GIT_HOME=${gitTool}"]) {
                        // Use the configured Git tool
                        checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/AdriIlegra/calculator.git']]])
                    }
                }
            }
        }
        stage('Build') {
            steps {
                // You can add your build steps here, like compiling and packaging your application.
                // For example:
                sh "gradle clean build"
            }
        }
        stage('Upload Artifact to JFrog') {
            steps {
                script {
                    def server = Artifactory.server 'calculadora' // Use the server name you configured
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
