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
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }

    //     stage('Push Image to Docker Hub') {         
    //         steps{                            
    //                 sh 'docker push $DOCKER_IMAGE'           
    //                 echo 'Push Image Completed'       
    //         }            
    //     }   
    }
}