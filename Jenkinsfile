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

        // Manual intervention before applying the changes
        stage('Manual Approval before Apply') {
            steps {
                input message: 'Do you approve applying the Terraform changes?', ok: 'Yes'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh "terraform apply --auto-approve"
            }
        }

        stage('Ansible Playbook Run') {
            steps {
                script {
                    // Get the instance's public IP from Terraform output
                    def instance_ip = sh(script: 'terraform output -raw instance_public_ip', returnStdout: true).trim()
                    
                    // Ensure proper permissions on the private key
                    sh """
                    chmod 600 /var/lib/jenkins/jobs/myproject/workspace/mynewsshkey.pem
                    ansible-playbook -i ${instance_ip}, install_nginx.yml --extra-vars "host=${instance_ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=/var/lib/jenkins/jobs/myproject/workspace/mynewsshkey.pem" -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"
                    """
                }
            }
        }

        // Manual intervention before destroying the resources
        stage('Manual Approval before Destroy') {
            steps {
                input message: 'Do you approve destroying the Terraform resources?', ok: 'Yes'
            }
        }

        stage('Terraform Destroy') {
            steps {
                sh "terraform destroy --auto-approve"
            }
        }
    }
}
