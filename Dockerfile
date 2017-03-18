FROM alpine:3.5

ENV TERRAFORM_VERSION 0.9.1

#Needed package install
RUN apk update
RUN apk add make curl unzip

#Install ansible
RUN apk add ansible

#Install terraform
RUN cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

WORKDIR sweady

CMD ["bin/bash"]