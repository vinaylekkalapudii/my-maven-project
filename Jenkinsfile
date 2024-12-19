pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = 'docker'  // The credentials ID from Jenkins (created in Jenkins > Manage Credentials)
    }

    stages {
        // Stage 1: Git Checkout
        stage('Git Checkout') {
            steps {
                script {
                    echo "Checking out the repository..."
                }
                git branch: 'main', url: 'https://github.com/vinaylekkalapudii/my-maven-project/'
            }
        }

        // Stage 2: Run Docker Build to create an image
        stage('Run Docker Build') {
            steps {
                script {
                    echo "Building the Docker image..."
                }
                sh 'docker build -t vinaylekkalapudii/newmavenjen:v1 .'  // Build the Docker image with tag 'v1'
            }
        }

        // Stage 3: Docker Login
        stage('Docker Login') {
            steps {
                script {
                    echo "Logging into Docker..."
                }
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"  // Docker login using credentials
                }
            }
        }

        // Stage 4: Docker Push
        stage('Docker Push') {
            steps {
                script {
                    echo "Running Docker container and pushing the image..."
                }
                sh 'docker run -d -p 5050:8080 vinaylekkalapudii/newmavenjen:v1'  // Run Docker container (optional, only if needed for testing)
                sh 'docker push vinaylekkalapudii/newmavenjen:v1'  // Push the Docker image to the registry
            }
        }
    }
}
