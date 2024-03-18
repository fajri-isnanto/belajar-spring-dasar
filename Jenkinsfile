pipeline {
    agent any
    tools{
        jdk 'OpenJDK11'
        maven 'Maven3'
    }
    stages {
        stage('Build') { 
            steps {
                sh 'mvn -B -DskipTests clean package' 
            }
        }
    }
}