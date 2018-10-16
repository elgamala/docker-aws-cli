FROM docker

RUN apk -v --update add \
        python \
        py-pip \
        groff \
        less \
        mailcap

RUN pip install --upgrade awscli==1.14.5 s3cmd==2.0.1 python-magic
RUN apk -v --purge del py-pip
RUN rm /var/cache/apk/*

VOLUME /root/.aws
VOLUME /code

WORKDIR /code
ENTRYPOINT ["aws"]
