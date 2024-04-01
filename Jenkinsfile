pipeline {
    agent {
        label 'java11'
    }
    environment {
        DOCKERHUB_CREDENTIALS=credentials('kalax1011')
        DOCKER_IMAGE = 'kalax1011/springboot'
        DOCKER_REPO = 'kalax1011/springboot'
        CONTAINER_NAME = 'springboot'
        // DOCKERHUB_CREDENTIALS_PSW = 'kodok1011'
        // DOCKERHUB_CREDENTIALS_USR = 'kalax1011'
    }

    stages {
        stage('Build JAR') { 
            steps {
                sh 'mvn -B -DskipTests clean package' 
                sh 'java -jar target/spring-1.jar'
            }
        }

    stage('Login to Docker Hub') {      	
            steps{                       	
                    //sh 'echo $DOCKERHUB_CREDENTIALS_PSW | sudo docker login -username $DOCKERHUB_CREDENTIALS_USR --password-stdin' 
                    sh 'echo "kodok1011" | docker login -u kalax1011 --password-stdin'               		
                    echo 'Login Completed'      
            }           
        } 

    stage('Build Image') {
            steps {
                // Build Docker image
                script {
                    //sh "docker build -t ${DOCKER_IMAGE} ."
                    docker.build("${DOCKER_IMAGE}:2")
                }
            }
        }

        stage('Push Image to Docker Hub') {         
            steps{                            
                    sh 'docker push $DOCKER_IMAGE:$'           
                    echo 'Push Image Completed'       
            }            
        }   

        stage('Delete Image after pushed') {         
            steps{                            
                    sh 'docker image rm  $DOCKER_IMAGE:$BUILD_NUMBER'           
            }       
        }

        stage('SSH to Docker Server') {
            steps{
                //ssh to server
                // sh 'sshpass -p "!qwerty7" ssh root@172.20.103.221'
                sh 'sshpass -p "!qwerty7" ssh -o StrictHostKeyChecking=no root@172.20.103.221'
                // sh 'docker pull $DOCKER_REPO'
            }
        }

        stage('Stop Docker Container') {
            steps{
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                sh 'docker container stop ${CONTAINER_NAME}'
                sh 'docker container rm ${CONTAINER_NAME}'
                }
            }
        }
        stage('Start Tomcat Container') {
            steps{
                sh 'docker run -d --name ${CONTAINER_NAME} -p 8021:8080 ${DOCKER_IMAGE}:{$BUILD_NUMBER}'
            }
        }
        // stage('cek Tomcat running') {
        //     steps{
        //         sh 'curl http://172.20.103.226:8021'
        //     }
        // }
    }
}