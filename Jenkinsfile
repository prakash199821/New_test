
pipeline {
    agent {
        node {
            label 'maven'
        }
    }
environment {
    PATH = "/opt/apache-maven-3.9.6/bin:$PATH"
}
    stages {
        stage("build"){
            steps {
                 echo "----------- build started ----------"
                sh 'mvn clean deploy -Dmaven.test.skip=true'
                 echo "----------- build completed ----------"
            }
        }

    stage('SonarQube analysis') {
    environment {
      scannerHome = tool 'vsonar-scanner'
    }
    steps{
    withSonarQubeEnv('sonarqube-server') { // If you have configured more than one global server connection, you can specify its name
      sh "${scannerHome}/bin/sonar-scanner"
      sh 'sonar-scanner -Dsonar.projectKey=pra23-key_prakash123 -Dsonar.organization=pra23 -X'
    }
    }
  }

           
}
}
