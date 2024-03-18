pipeline {
    agent {
        node {
            label "java11"
        }
    }
    stages {
        stage('Build') {
            steps {
                echo "hello build"
            }
        }
        stage('Test') {
            steps {
                echo "hello Test"
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploy"
            }
        }
        
    }
}