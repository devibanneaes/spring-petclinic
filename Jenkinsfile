pipeline{
    agent{label 'JAVA'}
    triggers{
        pollSCM('* * * * *')
    }
    stages{
        stage('git checkout'){
            steps{
                git url:'https://github.com/devibanneaes/spring-petclinic.git',
                    branch:'main'
            }
        }
        stage('build and scan'){
            steps{
                withCredentials([string(credentialsId:'mysonar_Id', variable:'SONAR')]){
                withSonarQubeEnv('sonar'){
                    sh """
                    mvn package sonar:sonar \
                    -Dsonar.projectKey='devibanne' \
                    -Dsonar.organization='devibanne' \
                    -Dsonar.host.url='https://sonarcloud.io/' \
                    -Dsonar.login=$SONAR
                                           """
                }
                }
            }
        }
    }
}