FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
    apt-get update -y && apt-get install google-cloud-sdk -y

RUN apt-get install kubectl && apt-get install google-cloud-sdk-gke-gcloud-auth-plugin

RUN curl -sL https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -o /usr/local/bin/yq && \
    chmod +x /usr/local/bin/yq

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

COPY jenkins/config.yaml /usr/local/config.yaml
ENV CASC_JENKINS_CONFIG /usr/local/config.yaml

COPY jenkins/plugins.txt /usr/local/plugins.txt

RUN jenkins-plugin-cli --plugin-file /usr/local/plugins.txt

COPY jenkins/init.groovy.d/ /usr/share/jenkins/ref/init.groovy.d/

COPY kubernetes/ /usr/share/jenkins/ref/kubernetes/
COPY jenkins/ /usr/share/jenkins/ref/
COPY images/ /usr/share/jenkins/ref/images/
