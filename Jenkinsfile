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

                    // Optionally, check if the IP is available before proceeding
                    if (!instance_ip) {
                        error "Failed to retrieve public IP from Terraform output."
                    }

                    // Add the instance's SSH key to known hosts to prevent "Host key verification failed"
                    sh """
                    ssh-keyscan -H ${instance_ip} >> ~/.ssh/known_hosts
                    """

                    // Run the Ansible playbook with the appropriate SSH private key and instance IP
                    sh """
                    ansible-playbook -i ${instance_ip}, install_nginx.yml --extra-vars "host=${instance_ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=/var/lib/jenkins/jobs/myproject/workspace/mynewsshkey.pem" \
                    -e ansible_ssh_common_args='-o StrictHostKeyChecking=no'
                    """
                }
            }
        }
    }
}
