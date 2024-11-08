pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Cloning the repository directly
                git branch: 'main', url: 'https://github.com/Viswaraje/angularlab.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile in the repository
                    // Ensure Docker is installed on the Windows machine
                    bat 'docker build -t my-angular-app:latest .'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run tests on Windows
                    // 'npm run test' is generally cross-platform, so this will work for both Linux and Windows
                    bat 'npm run test -- --watchAll=false'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Log into Docker registry and push the image
                    withCredentials([usernamePassword(credentialsId: 'docker-viswaraje', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        bat "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                        bat 'docker push my-angular-app:latest'
                    }
                }
            }
        }

        stage('Deploy to Production') {
            steps {
                script {
                    // Deploy the Docker container to production (for example, on a remote Windows server)
                    bat 'docker run -d -p 80:80 my-angular-app:latest'
                }
            }
        }
    }

    post {
        always {
            // Clean workspace after build
            cleanWs()
        }
    }
}
