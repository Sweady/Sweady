FROM alpine:3.5

ENV TERRAFORM_VERSION 0.9.0
ENV TZ=Europe/Paris

#Needed package install
RUN apk update && \
    apk add --no-cache make curl unzip ansible bash tzdata openntpd && \
    cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

WORKDIR /sweady
ADD . /sweady