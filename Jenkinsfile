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

        // stage('SSH to Docker Server') {
        //     steps{
        //         sh 'sshpass -p "!qwerty7" ssh -o StrictHostKeyChecking=no root@172.20.103.221'
        //     }
        // }
        stage('Stop Docker Container') {
            steps{
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                sh 'docker container stop ${CONTAINER_NAME}'
                sh 'docker container rm ${CONTAINER_NAME}'
                }
            }
        }

        stage('Check Running Container') {
            steps{
                script {
                    // Menyimpan status langkah sebelumnya
                    def previousBuildStatus = currentBuild.previousBuild?.result ?: 'SUCCESS'
                    
                    // Mengecek apakah langkah sebelumnya berhasil atau gagal
                    if (previousBuildStatus == 'SUCCESS') {
                        echo "Container ${CONTAINER_NAME} has stopped"
                    } else {
                        sh 'docker run -d --name ${CONTAINER_NAME} -p 8021:8080 ${DOCKER_IMAGE}:${VERSION_NUMBER}'
                    }
                }
            }
        }

        stage('Send Notifications Discord') {
            steps {
                // Print a hello message
                echo 'Hello, Discord!'

                // Send a notification to Discord
                discordSend(channel: 'https://discord.com/api/webhooks/1224199340470304768/y-0Lp0Hw8ocA6-noJ0k5yuuLOv6Q5ZhHjEEdk43P-up-10T2CzxsBQk2CmRSzC3Hzbel', color: '#0099ff', message: 'Hello from Jenkins!')
            }
        }

        
    }
post {
        always {  
    // Run docker system prune with automatic confirmation using 'yes'
    sh 'yes | docker system prune'
	sh 'docker logout'     
    // Send a notification to Discord regardless of the build result
    discordSend(channel: 'https://discord.com/api/webhooks/1224199340470304768/y-0Lp0Hw8ocA6-noJ0k5yuuLOv6Q5ZhHjEEdk43P-up-10T2CzxsBQk2CmRSzC3Hzbel', color: '#ff9900', message: "Build ${currentBuild.result}: ${currentBuild.fullDisplayName}")
        }   
        success {
            echo 'Pipeline succeeded! Docker image built and pushed.'
        }
        failure {
            echo 'Pipeline failed! Handle errors if needed.'
        }
    }
}