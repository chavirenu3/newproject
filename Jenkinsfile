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
    
        // Uncomment the Terraform Destroy stage if needed
        // stage('Terraform Destroy') {
        //     steps {
        //         sh "terraform destroy --auto-approve"
        //     }
        // }
        
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

        stage('Terraform Apply') {
            steps {
                sh "terraform apply --auto-approve"
            }
        }

        stage('Sleep 1 minute for warm-up') {
            steps {
                sh "sleep 60"
            }
        }

        stage('Ansible Playbook Run') {
            steps {
                script {
                    // Fetch the instance public IP from Terraform output
                    def instance_ip = sh(script: 'terraform output -raw instance_public_ip', returnStdout: true).trim()
                    
                    // Run the Ansible playbook with the fetched public IP
                    sh """
                    ansible-playbook -i ${instance_ip}, install_nginx.yml --extra-vars "host=${instance_ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/my_aws_terraform_ansible_project/terraform_codes/mynewsshkey.pem"
                    """
                }
            }
        }
    }
}
