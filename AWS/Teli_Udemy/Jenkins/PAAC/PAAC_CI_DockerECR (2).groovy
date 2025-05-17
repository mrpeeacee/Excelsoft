pipeline {
    agent any
    tools {
        maven "MAVEN3.9"
        jdk "JDK17"
    }


    environment {
        registryCredential = 'ecr:ap-south-1:awscreds'
        appRegistry = "921268854572.dkr.ecr.ap-south-1.amazonaws.com/nikvprofileappimg"
        vprofileRegistry = "https://921268854572.dkr.ecr.ap-south-1.amazonaws.com"
        imageName = "ESnik" + "$BUILD_NUMBER"
    }
  stages {
   
        stage('Fetch code') {
            steps {
               git branch: 'docker', url: 'https://github.com/hkhcoder/vprofile-project.git'
            }

        }


        stage('Build'){
            steps{
               sh 'mvn install -DskipTests'
            }

            post {
               success {
                  echo 'Now Archiving it...'
                  archiveArtifacts artifacts: '**/target/*.war'
               }
            }
        }

        stage('UNIT TEST') {
            steps{
                sh 'mvn test'
            }
        }

        stage('Checkstyle Analysis') {
            steps{
                sh 'mvn checkstyle:checkstyle'
            }
        }

        stage("Sonar Code Analysis") {
            environment {
                scannerHome = tool 'sonar6.2'
            }
            steps {
              withSonarQubeEnv('sonarserver') {
                sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                   -Dsonar.projectName=vprofile \
                   -Dsonar.projectVersion=1.0 \
                   -Dsonar.sources=src/ \
                   -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                   -Dsonar.junit.reportsPath=target/surefire-reports/ \
                   -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                   -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
              }
            }
        }

        stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
          }

        stage('Build App Image') {
          steps {
       
            script {
                dockerImage = docker.build( appRegistry + "$imageName", "./Docker-files/app/multistage/")
                }
          }
    
        }

        stage('Upload App Image') {
          steps{
            script {
              docker.withRegistry( vprofileRegistry, registryCredential ) {
                dockerImage.push("$imageName")
              }
            }
          }
        }
stage('Remove container Images'){
    steps{
        sh 'docker rmi -f $(docker images -a -q)'
    }
}
  }
}