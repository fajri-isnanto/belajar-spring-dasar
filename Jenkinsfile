pipeline {
    agent {
        label 'java11'
    }
    environment {
        DOCKERHUB_CREDENTIALS=credentials('kalax1011')
        DOCKER_IMAGE = 'kalax1011/springboot'
        DOCKER_REPO = 'kalax1011/springboot'
        CONTAINER_NAME = 'springboot'
        VERSION_NUMBER = '14'
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
                    sh 'echo "kodok1011" | docker login -u kalax1011 --password-stdin'               		
                    echo 'Login Completed'      
            }           
        } 

    stage('Build Image') {
            steps {
                // Build Docker image
                script {
                    //sh "docker build -t ${DOCKER_IMAGE} ."
                    docker.build("${DOCKER_IMAGE}:${VERSION_NUMBER}")
                }
            }
        }

    stage('Push Image to Docker Hub') {         
            steps{                            
                    sh 'docker push $DOCKER_IMAGE:$VERSION_NUMBER'           
                    echo 'Push Image Completed'       
            }            
        }   

    stage('Delete Image after pushed') {         
            steps{                            
                    sh 'docker image rm  $DOCKER_IMAGE:$VERSION_NUMBER'           
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

    stage('Running Container') {
            steps {
                sh 'docker run -d --name ${CONTAINER_NAME} -p 8021:8080 ${DOCKER_IMAGE}:${VERSION_NUMBER}'
            }
        }
    }

post {
        always {  
    // Run docker system prune with automatic confirmation using 'yes'
    sh 'yes | docker system prune'
	sh 'docker logout'   
    // Discord Notifications  
    discordSend description: '', footer: '', image: '', link: '', result: '', scmWebUrl: '', showChangeset: true, thumbnail: '', title: 'Pipeline: rumah-kita', webhookURL: 'https://discord.com/api/webhooks/1224199340470304768/y-0Lp0Hw8ocA6-noJ0k5yuuLOv6Q5ZhHjEEdk43P-up-10T2CzxsBQk2CmRSzC3Hzbel'
        }   
        success {
            echo 'Pipeline succeeded! Docker image built and pushed.'
        }
        failure {
            echo 'Pipeline failed! Handle errors if needed.'
        }
    }
}