pipeline {
    agent any
        environment {
        DOCKER_CREDENTIALS = 'docker'  // The credentials ID from Jenkins (created in Jenkins > Manage Credentials)
    }


    stages {
        stage('git checkout') {
            steps {
               git branch: 'main', url: 'https://github.com/vinaylekkalapudii/my-maven-project/'
            }
        }
        
        stage('run docker file and create image'){
            steps{
                sh 'docker build -t vinaylekkalapudii/newmavenjen:v1 .'
            }
        }
        stage('docker login'){
            steps{
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"  // Use credentials for login
               
                }
            }
        }
        
        stage("docker push"){
            steps{
                '''
                sh 'docker run -d -p 5050:8080 vinaylekkalapudii/newmavenjen:v1'
                sh 'docker push vinaylekkalapudii/newmavenjen:v1'
                '''
            }
        }
        
    }
}
