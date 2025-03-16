pipeline {
    agent any

    stages {
        stage('Clone Git Repo') {
            steps {
                git url: "https://github.com/chavirenu3/newproject.git", branch: "main"
            }
        }
    

        
        stage('Terraform INIT') {
            steps {
                sh "terraform init"
            }
        }
    
       
        stage('Terraform Plan') {
            steps {
                sh "terraform plan"
            }
        }
    }
}
