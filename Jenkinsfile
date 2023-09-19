pipeline
    agente any {
    tools {
    gradle 'gradle-3.5.0'
    }
    stages {
    stage('Build') {
    steps {
    sh 'gradle build'
    }
    }
    stage('Test') {
    steps {
    sh 'gradle test'
    }
    }
    }
    }