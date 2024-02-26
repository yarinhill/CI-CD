#!/bin/bash
sudo apt-get install openjdk-11-jdk
sudo mkdir -p /opt/gradle
wget -O ~/gradle-7.6.4-bin.zip https://services.gradle.org/distributions/gradle-7.6.4-bin.zip
sudo unzip -d /opt/gradle ~/gradle-7.6.4-bin.zip
sudo tee /etc/profile.d/gradle.sh <<EOF
export PATH=$PATH:/opt/gradle/gradle-7.6.4/bin
EOF
sudo chmod 755 /etc/profile.d/gradle.sh
