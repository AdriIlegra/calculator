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

                    }
                }
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
