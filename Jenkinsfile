pipeline {
    agent {
        label 'java11'
    }

    stages {
        stage('Build') { 
            steps {
                sh 'mvn -B -DskipTests clean package' 
            }
        }

        stage('Running JAR')
        steps {
            sh 'java -jar /var/lib/jenkins/workspace/rumah-kita/target/belajar-spring-dasar-0.0.1-SNAPSHOT.jar'
        }
    }
}