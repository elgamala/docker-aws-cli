![Docker Build](https://github.com/guitarrapc/docker-aws-cli/workflows/Docker%20Build/badge.svg) ![Docker Push](https://github.com/guitarrapc/docker-aws-cli/workflows/Docker%20Push/badge.svg) [![hub](https://img.shields.io/docker/pulls/guitarrapc/docker-awscli-kubectl.svg)](https://hub.docker.com/r/guitarrapc/docker-awscli-kubectl/)

## Builder docker image

An Alpine based docker image contains a good combination of commenly used tools to build, package as docker image, login and push to AWS ECR, AWS authentication and all Kuberentes staff.

The image is mainly used as a builder images while creating CICD pipelines.

## Versioning

version will match to the kubectl.
other tools will be updated on kubectl update time.

## Tools listing

|Tool                   |Version        |Description                                                                               |
|-----------------------|---------------|------------------------------------------------------------------------------------------|
|Docker Engine          |18.6           |Docker image containing docker engine to offer Docker inside Docker (DinD)                |
|AWS CLI                |1.18.24        |AWS commandline tools for managing simple infrastructure tasks                            |
|Python                 |3.8.2          |Usefull scripting language and also a common rerequisite for many other tools             |
|Pip                    |19.2.3         |Python package manager used to install many libraries and other tools i.e. aws-cli        |
|cUrl                   |7.67.0         |Commandline professional http(s) client tool                                              |
|Bash                   |4.4.19         |Advanced linux shell                                                                      |
|Envsubst               |1.1.0          |Simple tool to substitute template files with matching Environment Variables values       |
|aws-iam-authenticator  |1.16.8         |IAM authentication utility offers a secure proxy for authenticating kubectl to K8S cluster|
|Kubectl                |1.16.8         |Kubectl used to administrate the K8S cluster                                              |
|git                    |2.24.1         |World's most popular version control tool                                                 |
|helm                   |2.16.2         |Package manager for K8S clusters that simplifies complex deployments with simple Charts   |
|helm-s3 plugin         |0.9.2          |S3 integration plugin to use S3 as a private Helm Charts repositories                     |
|kubeval                |0.4.0          |Validate your Kubernetes configuration files, supports multiple Kubernetes versions       |
|dockerize              |0.6.1          |Utility to simplify running applications in docker containers                             |
|sops                   |3.5.0          |Simple and flexible tool for managing secrets                                             |

## Installation guide

Simply pull the image from official docker hub using the following command as it contains nothing more than a set of open source tools.

```sh
docker pull guitarrapc/docker-awscli-kubectl
```

## Even more useful in Gitlab

- Please use docker enabled gitlab runner and make sure docker engine is running in priviledged mode to enable Docker inside Docker (DinD). Learn more? https://docs.gitlab.com/runner/executors/docker.html#use-docker-in-docker-with-privileged-mode
- Use the image as your builder image to be loaded into the runner during the build step initiation and enable DinD service. To acheive this please add the following snippet to your pipeline code i.e. gitlab-ci.yaml.

```yaml
docker:
    stage: create-docker-image
    image: guitarrapc/docker-awscli-kubectl
    services:
        - docker:dind
    variables:
        DOCKER_DRIVER: overlay           # For better build performance

    script:
        - echo 'Your build scripts goes here and you can use all of the above toolset'
```

## Credits

Ahmed Sorour, https://github.com/aserour