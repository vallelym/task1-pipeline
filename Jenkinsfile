pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/vallelym/task1-pipeline.git', branch: 'main'
            }
        }
        stage('Build') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t my-flask-app .'
            }
        }
        stage('Trivy Scan') {
            steps {
                echo 'Running Trivy filesystem scan...'
                sh 'trivy fs --format json --output trivy-report.json /var/lib/jenkins/workspace/task1-pipeline'
            }
        }
        stage('Run') {
            steps {
                echo 'Starting Docker container...'
                sh 'docker run -d -p 5500:5500 --name my-flask-app my-flask-app:latest'
            }
        }
    }
    post {
        always {
            echo 'Cleaning up Docker containers...'
            sh 'docker container prune -f'
            echo 'Archiving Trivy scan report...'
            archiveArtifacts artifacts: 'trivy-report.json', allowEmptyArchive: true
        }
    }
}
