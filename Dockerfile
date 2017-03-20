FROM alpine:3.5

ENV TERRAFORM_VERSION 0.9.0
ENV ANSIBLE_HOST_KEY_CHECKING False

#Needed package install
RUN apk update && \
    apk add --no-cache make curl unzip bash tzdata openntpd python py-pip openssl ca-certificates python-dev libffi-dev openssl-dev build-base && \
    pip install --upgrade pip cffi && \
    pip install ansible && \
    cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

WORKDIR /sweady
ADD . /sweady