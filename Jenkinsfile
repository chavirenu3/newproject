pipeline {
    agent any

    stages {
        stage('Clone Git Repo') {
            steps {
                git credentialsId: 'gitchavirenu', url: 'https://github.com/chavirenu3/newproject.git'
            }
        }
    }
}
