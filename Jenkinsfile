pipeline{
    agent any

    environment{
        dockerImage="geeta/demo-app"
        dockerTag="${BUILD_NUMBER}"
    }

    triggers{
        githubPush()
    }

    stages{
        stage('Fetch code'){
            steps{
                git branch: 'main', url: 'https://github.com/GeetaSree13/Docker_Assignment.git'
            }
        }

        stage('Build Docker Image'){
            steps{
                script{
                    docker.build("${dockerImage}:${dockerTag}")
                }
            }
        }

        stage('Push Docker Image'){
            steps{
                script{
                    docker.withRegistry('https://index.docker.io/v1/','dockerhub-credentials'){
                        docker.image("${dockerImage}:${dockerTag}").push()
                        docker.image("${dockerImage}:${dockerTag}").push('latest')
                    }
                }
            }
        }

        stage('deploy container'){
            steps{
                script{
                    sh 'docker rm -f demo-app || true'
                    sh "docker run -d --name demo-app -p 8081:8081 ${dockerImage}:${dockerTag}"           
                }
            }
        }
    }

    post{
        success{
            echo "app deployed successfully"
        }
        failure{
            echo "app deployment failed"
        }
    }
}