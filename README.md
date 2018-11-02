# Builder docker image 

[hub]: https://hub.docker.com/r/asorour/docker-aws-cli


An Alpine based docker image contains a good combination of commenly used tools to build, package as docker image, login and push to AWS ECR, AWS authentication and all Kuberentes staff.


## Tools listing

|Tool                   |Version        |Description                                                                               |
|-----------------------|---------------|------------------------------------------------------------------------------------------|
|Docker Engine          |18.6           |Docker image containing docker engine to offer Docker inside Docker (DinD)                |
|AWS CLI                |1.16.25        |AWS commandline tools for managing simple infrastructure tasks                            |
|Python                 |3.6.6          |Usefull scripting language and also a common rerequisite for many other tools             |
|Pip                    |18.1           |Python package manager used to install many libraries and other tools i.e. aws-cli        |
|cUrl                   |7.61.1         |Commandline professional http(s) client tool                                              |
|Bash                   |4.4.19         |Advanced linux shell                                                                      |
|Envsubst               |1.1.0          |Simple tool to substitute template files with matching Environment Variables values       |
|aws-iam-authenticator  |1.10.3         |IAM authentication utility offers a secure proxy for authenticating kubectl to K8S cluster|
|Kubectl                |1.10.3         |Kubectl used to administrate the K8S cluster                                              |
|git                    |2.18.1         |World's most popular version control tool                                                 ||helm                   |2.10.0         |Package manager for K8S clusters that simplifies complex deployments with simple Charts   |
|helm-s3 plugin         |0.7.0          |S3 integration plugin to use S3 as a private Helm Charts repositories                     |

The image is mainly used as a builder images while creating CICD pipelines.
