#!/bin/bash
set -e

# Update system packages
sudo apt-get update
sudo apt-get upgrade -y

# Install Docker
sudo apt-get install -y docker.io
sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Git
sudo apt-get install -y git

# Clone the repository
cd /home/ubuntu
git clone https://github.com/Rohit001001/Task-2-Set-up-a-basic-Jenkins-pipeline-for-deploying-an-application.git app
cd app

# Build and run the Docker container
sudo docker build -t myapp:latest .
sudo docker run -d -p 80:80 --name myapp --restart unless-stopped myapp:latest

# Create a status file
echo "Application deployed successfully" > /home/ubuntu/deploy_status.txt
date >> /home/ubuntu/deploy_status.txt
