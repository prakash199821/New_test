pipeline {
    agent { label 'maven'}

environment {
    PATH = "/opt/apache-maven-3.9.6/bin:$PATH"
}

    stages {
        stage("build") {
            steps {
                  echo "-----------Build Started----------"
                sh 'mvn clean deploy'
                  echo "-----------Build Completed------"
            }
        stage('SonarQube analysis') {
            environment {
            scannerHome = tool 'valaxy-sonar-scanner'
            }
            steps {
               withSonarQubeEnv('valaxy-sonarqube-server') { 
               sh "${scannerHome}/bin/sonar-scanner" }
                }
            }
        } 
    }
}




