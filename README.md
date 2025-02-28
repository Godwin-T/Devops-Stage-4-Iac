# Infrastructure Deployment with Terraform & Ansible

This repository contains infrastructure as code (IaC) configurations for deploying a web server using Terraform and Ansible. The setup provisions an AWS EC2 instance, configures security groups, and deploys an application using Ansible.

## Table of Contents
- [Requirements](#requirements)
- [Setup Instructions](#setup-instructions)
- [Infrastructure Description](#infrastructure-description)
- [Environment Variables](#environment-variables)

## Requirements
Ensure you have the following installed on your local machine:
- Terraform (>= 1.0)
- Ansible (>= 2.9)
- AWS CLI configured with appropriate credentials
- SSH key pair for accessing the server

## Setup Instructions

1. **Clone the repository:**
   ```sh
   git clone https://github.com/your-repo.git
   cd your-repo

2. **Initialize Terraform:**
    ```sh
    terraform init

3. **Apply Terraform configuration to provision resources:**
    ```sh
    terraform apply -auto-approve


## Infrastructure Description

AWS EC2 Instance: Provisions a t2.small instance.
Security Groups: Allows inbound traffic on ports 22 (SSH), 80 (HTTP), and 443 (HTTPS).
Local Inventory File: Automatically creates an Ansible inventory file with the instance's public IP.
Ansible Configuration: Installs necessary dependencies and deploys the application.

## Environment Variables
Ensure the following variables are correctly configured:

- AWS_ACCESS_KEY_ID – Your AWS access key
- AWS_SECRET_ACCESS_KEY – Your AWS secret key
- ANSIBLE_HOST_KEY_CHECKING – Set to False to prevent host key verification issues