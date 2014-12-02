#!/bin/sh

# Install Packages
apt-get -y update
apt-get install -y -q \
    openjdk-7-jre-headless \
    curl \
    git

# Install jenkins
curl -L -o /opt/jenkins.war http://mirrors.jenkins-ci.org/war/1.590/jenkins.war
chmod 644 /opt/jenkins.war

# Cleanup
apt-get clean
