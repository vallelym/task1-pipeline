pipeline {
    agent any

    stages {
        stage('Clean-Up') {
            steps {
                echo 'Cleaning up workspace...'
                deleteDir() // Deletes the contents of the workspace
            }
        }

        stage('Build') {
            steps {
                echo 'Building Docker image...'
                script {
                    def app = docker.build("my-flask-app")
                }
            }
        }

        stage('Run') {
            steps {
                echo 'Running Docker container...'
                script {
                    docker.image("my-flask-app").run('-d -p 80:80')
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up Docker containers...'
            sh 'docker container prune -f'
        }
    }
}
