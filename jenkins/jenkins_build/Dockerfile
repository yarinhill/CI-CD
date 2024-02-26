FROM jenkins/jenkins

USER root

RUN \
    echo "Installing Packages" && \
    apt-get update && \
    apt-get install -y --no-install-recommends apt-utils bash sudo apt-transport-https software-properties-common wget curl vim git && \
    usermod -aG sudo jenkins && \
    echo "jenkins:password" | chpasswd && \
    echo "Packages Installed successfully"

COPY ./plugins.txt /usr/share/jenkins/ref/plugins.txt 
COPY ./plugins.txt /usr/share/jenkins/ref/plugins/plugins.txt

RUN \
    echo "Installing the Jenkins Plugins, this may take a while" && \
    mkdir -p /usr/share/jenkins/jenkins-plugins-cli /var/lib/jenkins /usr/lib/jvm && \
    curl -L https://github.com/jenkinsci/plugin-installation-manager-tool/releases/latest/download/jenkins-plugin-manager-2.10.0.jar \
         -o /usr/share/jenkins/jenkins-plugins-cli/jenkins-plugin-manager.jar && \
    chown -R jenkins:jenkins /usr/share/jenkins/jenkins-plugins-cli && \
    chmod 700 /usr/share/jenkins/jenkins-plugins-cli && \
    su jenkins -c "chmod 700 /usr/share/jenkins/jenkins-plugins-cli/*" && \
    chmod +x /usr/share/jenkins/ref/plugins.txt /usr/share/jenkins/ref/plugins/plugins.txt && \
    jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/usr/share/jenkins/aws.zip" && \
    unzip /usr/share/jenkins/aws.zip -d /usr/share/jenkins/ && \
    /usr/share/jenkins/aws/install && \
    echo "Jenkins Plugins Installed successfully"

RUN \
    echo "Installing Java-11, this may take a while" && \
    curl -L -o /tmp/openjdk.tar.gz https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.9%2B11/OpenJDK11U-jdk_x64_linux_hotspot_11.0.9_11.tar.gz && \
    tar xzf /tmp/openjdk.tar.gz -C /usr/lib/jvm --strip-components=1 && \
    rm -rf /usr/share/jenkins/aws.zip /tmp/openjdk.tar.gz /usr/share/jenkins/ref/plugins.txt /usr/share/jenkins/ref/plugins/plugins.txt && \
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

ENV JENKINS_OPTS --argumentsRealm.roles.user=admin --argumentsRealm.passwd.admin=admin --argumentsRealm.roles.admin=admin
ENV TZ Asia/Jerusalem
ENV JENKINS_HOME /var/lib/jenkins
ENV HOME /var/lib/jenkins

RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose && \
    usermod -aG docker jenkins && \ 
    chown -R jenkins:jenkins $HOME && \
    find $HOME/ -depth -exec sudo chown -R jenkins:jenkins {} \; && \ 
    echo "Docker Installed successfully"
    
USER jenkins
