pipeline {
    agent any

    tools {
        git 'Default'  // This should match the name you gave the Git tool in the Global Tool Configuration
    }

    environment {
        // Define environment variables for AWS credentials from Jenkins Secret Text
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')  // Secret text for AWS Access Key ID
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')  // Secret text for AWS Secret Access Key
        TF_VAR_private_key = '/home/ubuntu/my_aws_terraform_ansible_project/terraform_codes/mynewsshkey.pem'  // Your private key file
        ANSIBLE_HOST = ''  // This will be set later dynamically from Terraform output
        ANSIBLE_SSH_USER = 'ubuntu'
    }

    stages {
        stage('Clone Git Repo') {
            steps {
                // Checkout the code from the GitHub repo containing your Terraform code and Ansible playbook
                git credentialsId: 'gitchavirenu', url: 'https://github.com/chavirenu3/newproject.git'
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Initialize Terraform with AWS credentials set as environment variables
                    sh '''
                    export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                    export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                    terraform init
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply Terraform to create EC2 instance
                    // Use `-auto-approve` to avoid manual approval
                    sh '''
                    export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                    export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                    terraform apply -auto-approve
                    '''
                }
            }
        }

        stage('Get EC2 Public IP') {
            steps {
                script {
                    // Get the EC2 instance public IP after Terraform has created it
                    // We will store this in an environment variable for later use
                    ANSIBLE_HOST = sh(script: "terraform output -raw instance_public_ip", returnStdout: true).trim()
                    echo "EC2 Public IP: ${ANSIBLE_HOST}"
                }
            }
        }

        stage('Ansible Playbook') {
            steps {
                script {
                    // Run Ansible playbook to install Nginx on the EC2 instance
                    sh """
                    export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                    export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                    ansible-playbook -i '${ANSIBLE_HOST},' install_nginx.yml \
                    --extra-vars 'host=${ANSIBLE_HOST} ansible_ssh_user=${ANSIBLE_SSH_USER} ansible_ssh_private_key_file=${TF_VAR_private_key}'
                    """
                }
            }
        }
    }

    post {
        always {
            // Clean up workspace, files, etc.
            echo 'Cleaning up...'
        }
    }
}
