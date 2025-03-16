pipeline {
    agent any

    stages {
        stage('Clone Git Repo') {
            steps {
                git url: "https://github.com/chavirenu3/newproject.git", branch: "main"
            }
        }
    }

        stages {
        stage('Terraform INIT') {
            steps {
                sh "terraform init"
            }
        }
    }
            stages {
        stage('Terraform Plan') {
            steps {
                sh "terraform plan"
            }
        }
    }
}
