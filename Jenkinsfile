echo 'pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials("docker-hub-credentials")
        DOCKER_IMAGE = "your-dockerhub-username/my-flask-app"
    }
    stages {
        stage("Checkout") {
            steps {
                git url: "https://github.com/vallelym/task1-pipeline.git", branch: "main"
            }
        }
        stage("Build") {
            steps {
                echo "Building Docker image..."
                sh "docker build -t my-flask-app ."
            }
        }
        stage("Trivy Scan") {
            steps {
                echo "Running Trivy filesystem scan..."
                sh "trivy fs --format json --output trivy-report.json /var/lib/jenkins/workspace/task1-pipeline"
            }
        }
        stage("Run") {
            steps {
                echo "Starting Docker container..."
                sh "docker run -d -p 5500:5500 --name my-flask-app my-flask-app:latest"
            }
        }
        stage("Test") {
            steps {
                echo "Running unit tests..."
                sh '''
                cat <<EOF > test_flask_app.py
                import requests
                import unittest

                class FlaskAppTests(unittest.TestCase):
                    BASE_URL = "http://localhost:5500"

                    def test_home_page(self):
                        response = requests.get(f"{self.BASE_URL}/")
                        self.assertEqual(response.status_code, 200)
                        self.assertIn("Hello QA", response.text)
                        self.assertIn("I'm currently running in", response.text)

                if __name__ == "__main__":
                    unittest.main()
                EOF
                python3 -m unittest test_flask_app.py
                '''
            }
        }
        stage("Push to DockerHub") {
            steps {
                script {
                    docker.withRegistry("https://registry.hub.docker.com", "docker-hub-credentials") {
                        def app = docker.build("${DOCKER_IMAGE}:${env.BUILD_ID}")
                        app.push()
                    }
                }
            }
        }
    }
    post {
        always {
            echo "Cleaning up Docker containers..."
            sh "docker container prune -f"
            echo "Archiving Trivy scan report..."
            archiveArtifacts artifacts: "trivy-report.json", allowEmptyArchive: true
        }
    }
}' > Jenkinsfile
git add Jenkinsfile
git commit -m "Update Jenkinsfile with DockerHub push stage"
git push
