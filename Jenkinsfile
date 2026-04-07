pipeline {
    agent { label 'spc' }

    environment {
        image_name = 'spc'
        tag_name = '1.0'
    }

    triggers {
        pollSCM('* * * * *')
    }

    stages {

        stage('git checkout') {
            steps {
                git url: 'https://github.com/devibanneaes/spring-petclinic.git',
                    branch: 'main'
            }
        }

    

            
        

             //    stage('build and scan') {
            // steps {
                // withCredentials([string(credentialsId: 'sonar_id', variable: 'SONAR')]) {
                    // withSonarQubeEnv('sonar') {
                        //  sh """
                //  /       mvn clean package sonar:sonar \
                        // -Dsonar.projectKey=devibanneaes \
                        // -Dsonar.organization=devibanneaes \
                        // -Dsonar.host.url=https://sonarcloud.io \
                        // -Dsonar.login=$SONAR
                        // """
                    
                
            
        
        
        stage('Docker Image Build'){
            steps {
               sh "docker build -t ${image_name}:${tag_name} ."
            }
        }
        stage('trivy scan for image'){
            steps {
              sh "trivy image ${image_name}:${tag_name}" 
            }   
        }  
    
        stage('Image push to the ECR'){
            steps {
                sh """
                      aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 969578073062.dkr.ecr.ap-south-1.amazonaws.com
                      docker tag ${image_name}:${tag_name} 969578073062.dkr.ecr.ap-south-1.amazonaws.com/dev/spcjava:latest
                      docker push 969578073062.dkr.ecr.ap-south-1.amazonaws.com/dev/spcjava:latest
                """

            }
        }     

        stage('deploy to k8s for dev') {
           steps {
              withKubeConfig([credentialsId: 'myeks']) {
                  sh 'kubectl apply -f deploy-k8s/.'
                  sh 'kubectl get pods --namespace dev'

               }
            }
        }        
        
    
  
            
        


                 

    

        // // post {
        //     always {
        //     archiveArtifacts artifacts: '***/*.jar'
        //     junit '**/surefire-reports/*.xml'
          // }
           
        
        
    }
}            

        
                    
        


    
      
          
    