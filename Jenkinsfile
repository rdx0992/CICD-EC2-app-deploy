pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                // Pull the Todo app image
                sh 'docker pull errahul/node1-app:latest'
            }
        }
        stage('Stop Previous Container') {
            steps {
                script {
                    def containerID = sh(script: "docker ps -q --filter ancestor=errahul/node1-app:latest", returnStdout: true).trim()
                    if (containerID != "") {
                        sh "docker stop ${containerID}"
                        sh "docker rm ${containerID}"
                    }
                }
            }
        }
        stage('Approval') {
            steps {
                // Test the deployed application
                script {
                    input message: 'Is image pulled correctly?', ok: 'Confirm' // Prompt human acceptance
                }
            }
        }
        stage('Deploy') {
            steps {
                // Deploy the Todo app
                sh 'docker run -d -p 8000:8000 --name todo-app errahul/node1-app:latest'
            }
        }
        stage('Testing') {
            steps {
                // Test the deployed application
                script {
                    sh 'docker ps | grep todo-app'
                    sh 'docker exec todo-app npm test'
                    echo "everything running fine"
                }
            }
        }
        stage('Accepting') {
            steps {
                // Test the deployed application
                script {
                    input message: 'Is the application working as expected?', ok: 'Confirm' // Prompt human acceptance
                }
            }
        }
        stage('Push'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
        	     sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                 sh 'docker push errahul/my-app1:latest'
                }
            }
        }
    }
}
