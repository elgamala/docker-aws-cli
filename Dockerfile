FROM docker

LABEL tools="docker-image, gitlab-aws, aws, helm, helm-charts, docker, gitlab, gitlab-ci, kubectl, s3, aws-iam-authenticator, ecr, bash, envsubst, alpine, curl, python3, pip3, git"
LABEL version="1.0.0"
LABEL description="An Alpine based docker image contains a good combination of commenly used tools\
 to build, package as docker image, login and push to AWS ECR, AWS authentication and all Kuberentes staff. \
 tools included: Docker, AWS-CLI, Kubectl, Helm, Curl, Python, Envsubst, Python, Pip, Git, Bash, AWS-IAM-Auth."
LABEL maintainer="eng.ahmed.srour@gmail.com"

ENV AWS_CLI_VERSION 1.16.81


RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache


RUN apk --no-cache update && \
    apk --no-cache add curl jq make bash ca-certificates groff less && \
    pip3 install --upgrade awscli urllib3 && \
    pip3 --no-cache-dir install awscli==${AWS_CLI_VERSION} docker-compose wget && \
    rm -rf /var/cache/apk/*

ADD https://github.com/a8m/envsubst/releases/download/v1.1.0/envsubst-Linux-x86_64 /usr/local/bin/envsubst
RUN chmod +x /usr/local/bin/envsubst


ADD https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
RUN chmod +x /usr/local/bin/aws-iam-authenticator

# Get the kubectl binary.
ADD https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/kubectl /usr/local/bin/kubectl

# Make the kubectl binary executable.
RUN chmod +x /usr/local/bin/kubectl

# Install GIT
RUN apk add --no-cache git

#ENV HELM_HOME=~/.helm
#RUN mkdir -p ~/.helm/plugins

#RUN git clone https://github.com/hypnoglow/helm-s3.git

# Install Helm
ADD https://storage.googleapis.com/kubernetes-helm/helm-v2.12.1-linux-amd64.tar.gz helm-linux-amd64.tar.gz
RUN tar -zxvf helm-linux-amd64.tar.gz
RUN mv linux-amd64/helm /usr/local/bin/helm

# Initialize Helm

RUN helm init --client-only

# Install Helm S3 Plugin
RUN helm plugin install https://github.com/hypnoglow/helm-s3.git

# Cleanup apt cache
RUN rm -rf /var/cache/apk/*

ENV LOG=file
#ENTRYPOINT ["docker --version"]
#CMD []

#CMD [jq -version]

#VOLUME /var/run/docker.sock:/var/run/docker.sock

WORKDIR /data
