pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/vallelym/task1-pipeline.git'
            }
        }
        stage('Build') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t my-flask-app .'
            }
        }
        // Other stages...
    }
    post {
        always {
            echo 'Cleaning up Docker containers...'
            sh 'docker container prune -f'
        }
    }
}
