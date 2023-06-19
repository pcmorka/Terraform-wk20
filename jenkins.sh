#Bootstrap Jenkins installation and start  
#!/bin/bash
#Ensure that your software packages are up to date on your instance by using the following command to perform a quick software update:
  sudo yum update –y
#Add the Jenkins repo using the following command:
  sudo wget -O /etc/yum.repos.d/jenkins.repo \https://pkg.jenkins.io/redhat-stable/jenkins.repo
#Import a key file from Jenkins-CI to enable installation from the package:
  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
  sudo yum upgrade -y 
#Install Java (Amazon Linux 2):
  sudo amazon-linux-extras install java-openjdk11 -y
#Install Jenkins:
  sudo yum install jenkins -y
#Enable the Jenkins service to start at boot:
  sudo systemctl enable jenkins
#Start Jenkins as a service:
  sudo systemctl start jenkins
  sudo systemctl status jenkins
