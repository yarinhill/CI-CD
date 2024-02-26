FROM jenkins/ssh-agent

USER root

RUN \
    echo "Installing Packages" && \
    apt-get update && \
    apt-get install -y --no-install-recommends apt-utils sudo bash apt-transport-https software-properties-common wget curl vim dos2unix openssl ca-certificates iputils-ping zip unzip gnupg jq git && \ 
    usermod -aG sudo jenkins && \
    echo "jenkins:password" | chpasswd && \ 
    mkdir -p /var/lib/agent /usr/share/jenkins /usr/lib/jvm && \ 
    echo "Packages Installed successfully" 

RUN \
    echo "Installing AWS CLI, this may take a while" && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/usr/share/jenkins/aws.zip" && \
    unzip /usr/share/jenkins/aws.zip -d /usr/share/jenkins/ && \
    /usr/share/jenkins/aws/install && \
    echo "AWS CLI Installed successfully"

RUN \
    echo "Installing Java-11, this may take a while" && \
    curl -L -o /tmp/openjdk.tar.gz https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.9%2B11/OpenJDK11U-jdk_x64_linux_hotspot_11.0.9_11.tar.gz && \
    tar xzf /tmp/openjdk.tar.gz -C /usr/lib/jvm --strip-components=1 && \
    rm /tmp/openjdk.tar.gz /usr/share/jenkins/aws.zip && \
    echo "Java-11 Installed successfully"

RUN \ 
    echo "Installing Docker" && \
    sudo install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    sudo chmod a+r /etc/apt/keyrings/docker.gpg 

RUN echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

ENV HOME /home/jenkins
ENV JENKINS_AGENT_HOME=/home/jenkins
ENV AGENT_WORKDIR=/home/jenkins/agent
RUN export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
ENV JENKINS_AGENT_SSH_PUBKEY ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHvUn9lSUg+vy2LXDdB3ThELEJnHPTUturBAaxEZXfU3hs77210Efy2FvIr61/9xwZCEQVQqfVTmMtwvOFS2CMiVNjIxl3UKSzmONPm5VMh0Nr28rtc9N3srrUkSBzktnLxLPBDqpp3Mt4FkNPM5ZnxBB5hcJlmIW2cXz5najA8CFFXJHT5Dhxhib3BeN6+cBJ44XOIwToMcAKmFTseBlaLPPVFei6O8bO0KzGlZDIWbDpPXHtgoGYwyuNGMA06dm+NRata2H76lmtlxviuWPiuPGSx3L2CmQ9DDVSMoaLDMylIJWfEnzozqnQUngxqeQ8rgynxsl8noojCoCPFXKJtdEz15LldGokSNWrXQPN8wltdsO4YjhGV/nMO3YFpAU2L8kHMNy4pINSZdX0Ci7Vv4lnOx2ugnBup/7Mrn9KGyO2WQdYBt8RjHdkRjSZRqKsW3DBP0Ij1kSP6bEzFZFG5u1evo4zCRy/Pwt1Br6XXiLXyuyzuWpBohStADyagpN+YYYXNshjc6ub0ftxNOlWhUaUbkfEc/9Po2qXXNuV2Vf0i1eYQ8x5akDHWmub+brTiZPCcvyfRj8+tahtYD63isMxI1LRY00sZxyN2c21Sz8fquc0A3XLMe4wAQOhgV9oi8ShPioJ0s6LGDuWchGwMrfmUTqtYm2x178wjbkueQ== agent
ENV TZ Asia/Jerusalem

RUN \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose && \
    usermod -aG docker jenkins && \
    chown -R jenkins:jenkins $JENKINS_AGENT_HOME && \
    find $JENKINS_AGENT_HOME/ -depth -exec sudo chown -R jenkins:jenkins {} \; && \ 
    echo "Docker Installed successfully"
