pipeline{
    agent any
    stages{
        stage("code checkout"){
            steps{
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/vinaylekkalapudii/my-maven-project'
            }
        }
        stage("maven build"){
            steps{
                sh "mvn clean package"
            }
        }
        stage("tomcat deploy -dev"){
            steps{
                sshagent(['tomcat.dev']) {
                  sh" scp -o StrictHostKeyChecking=no target/my-maven-project.war ec2-user@172.31.24.34:/opt/tomcat10/webapps"
                   sh" ssh ec2-user@172.31.24.34 /opt/tomcat10/bin/shutdown.sh"
                   sh" ssh ec2-user@172.31.24.34 /opt/tomcat10/bin/startup.sh"
                }
            }
        }
    }
}
