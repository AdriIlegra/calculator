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
                        sh """
                            git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/teste 1/.git
                            git config remote.origin.url https://github.com/AdriIlegra/calculator.git
                            git fetch --tags --force --progress -- https://github.com/AdriIlegra/calculator.git +refs/heads/*:refs/remotes/origin/*
                            git rev-parse refs/remotes/origin/master^{commit}
                        """
                    }
                }
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
