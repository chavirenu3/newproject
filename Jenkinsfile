pipeline {
    agent any


    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')  // Use the Jenkins credentials ID for AWS access key
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')  // Use the Jenkins credentials ID for AWS secret key
    }

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
