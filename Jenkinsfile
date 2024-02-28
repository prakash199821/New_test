def registry = 'https://prakash012.jfrog.io'
def imageName = 'prakash012.jfrog.io/prakash-docker-local/ttrend'
def version   = '2.1.2'
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

/*      stage('SonarQube analysis') {
    environment {
     // scannerHome = tool 'vsonar-scanner'
    }
   steps{
    withSonarQubeEnv('sonarqube-server') { // If you have configured more than one global server connection, you can specify its name
      sh "${scannerHome}"
       sh 'vsonar-scanner'
    }
    }
      } */
      

    
  
        stage("Jar Publish") {
        steps {
            script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"415bcf63-6650-49d0-bc1d-1d980529e9f4"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",
                              "target": "prakash-libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Publish Ended --------------->'  
            
            }
        }   
    }  

           
    stage(" Docker Build ") {
      steps {
        script {
           echo '<--------------- Docker Build Started --------------->'
           app = docker.build(imageName+":"+version)
           echo '<--------------- Docker Build Ends --------------->'
        }
      }
    }

            stage (" Docker Publish "){
        steps {
            script {
               echo '<--------------- Docker Publish Started --------------->'  
                docker.withRegistry(registry, '415bcf63-6650-49d0-bc1d-1d980529e9f4'){
                    app.push()
                }    
               echo '<--------------- Docker Publish Ended --------------->'  
            }
        }
    }
    }}
