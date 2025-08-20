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

        sstage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials',
                                                  usernameVariable: 'DOCKER_USER',
                                                  passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                        docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest
                        docker push ${DOCKER_IMAGE}:latest
                    """
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