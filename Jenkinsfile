        pipeline {
    agent { label 'spc' }

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

        stage('build and scan') {
            steps {
                withCredentials([string(credentialsId: 'sonar_id', variable: 'SONAR')]) {
                    withSonarQubeEnv('sonar') {
                        sh """
                        mvn clean package sonar:sonar \
                        -Dsonar.projectKey=devibanneaes \
                        -Dsonar.organization=devibanneaes \
                        -Dsonar.host.url=https://sonarcloud.io \
                        -Dsonar.login=$SONAR
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '* * * /*.jar',
            junit '* */surefire-reports/* .xml'
        }
    }
}
        
