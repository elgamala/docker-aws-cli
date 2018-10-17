FROM docker

ENV AWS_CLI_VERSION 1.16.25

RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache


RUN apk --no-cache update && \
    apk --no-cache add curl ca-certificates groff less && \
    pip3 install --upgrade awscli && \
    pip3 --no-cache-dir install awscli==${AWS_CLI_VERSION} docker-compose wget && \
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


# Get the kubectl binary.
ADD https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/kubectl /usr/local/bin/kubectl

# Make the kubectl binary executable.
RUN chmod +x /usr/local/bin/kubectl

ENV LOG=file
#ENTRYPOINT ["docker --version"]
CMD []


#VOLUME /var/run/docker.sock:/var/run/docker.sock

WORKDIR /data
