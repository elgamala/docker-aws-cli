FROM docker

ENV AWS_CLI_VERSION 1.15.47


RUN apk --no-cache update && \
    apk --no-cache add python curl py-pip py-setuptools ca-certificates groff less && \
    pip install --upgrade pip && \
    pip --no-cache-dir install awscli==${AWS_CLI_VERSION} docker-compose wget && \
    rm -rf /var/cache/apk/*

ADD https://github.com/a8m/envsubst/releases/download/v1.1.0/envsubst-Linux-x86_64 /usr/local/bin/envsubst
RUN chmod +x /usr/local/bin/envsubst

# Install Docker from Docker Inc. repositories.
#RUN curl -sSL https://get.docker.com/ | sh && \
#RUN    apt-get update && \
#    apt-get upgrade -y && \
#RUN    apk add  wget
#    rm -rf /var/lib/apt/lists/*

#RUN curl -s -L https://github.com/docker/compose/releases/latest | \
#    egrep -o '/docker/compose/releases/download/[0-9.]*/docker-compose-Linux-x86_64' | \
#    wget --base=http://github.com/ -i - -O /usr/local/bin/docker-compose && \
#    chmod +x /usr/local/bin/docker-compose && \
#    /usr/local/bin/docker-compose --version

ADD https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
RUN chmod +x /usr/local/bin/aws-iam-authenticator

# Set the Kubernetes version as found in the UCP Dashboard or API
ENV k8sversion v1.8.11

# Get the kubectl binary.
ADD https://storage.googleapis.com/kubernetes-release/release/$k8sversion/bin/linux/amd64/kubectl /usr/local/bin/kubectl

# Make the kubectl binary executable.
RUN chmod +x /usr/local/bin/kubectl
RUN /usr/local/bin/kubectl verion

ENV LOG=file
#ENTRYPOINT ["docker --version"]
CMD []


#VOLUME /var/run/docker.sock:/var/run/docker.sock

WORKDIR /data
