# This Dockerfile is used to build an image which is used in circle CI
# to run the the following check or validation:
# markdownlint
# misspell
# ShellCheck
# gometalinter
FROM ubuntu:16.04

# update node source for apt
RUN apt-get update && apt-get install -y curl && apt-get clean 

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - 

# shellcheck is included in this installation command.
RUN apt-get update \
    && apt-get install -y rubygems git curl wget shellcheck nodejs make \
    && gem install rake \
    && gem install bundler \
    && apt-get clean   

# install golang
# set go binary path to local $PATH
# go binary path is /usr/local/go/bin
ENV GO_VERSION=1.12.6
ENV ARCH=amd64
RUN wget --quiet https://storage.googleapis.com/golang/go${GO_VERSION}.linux-${ARCH}.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-${ARCH}.tar.gz \
    && rm go${GO_VERSION}.linux-${ARCH}.tar.gz

# create GOPATH
RUN mkdir /go
ENV GOPATH=/go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

# install markdownlint
RUN git clone https://github.com/markdownlint/markdownlint.git \
    && cd markdownlint && git checkout v0.5.0 && rake install

# install markdown-link-check from https://github.com/tcort/markdown-link-check
RUN npm install -g markdown-link-check

# install gometalinter containing misspell
RUN go get -u github.com/alecthomas/gometalinter
RUN gometalinter --install > /dev/null

# install swagger
ENV SWAGGER_VERSION=v0.19.0

RUN wget --quiet -O /usr/local/bin/swagger \
    "https://github.com/go-swagger/go-swagger/releases/download/${SWAGGER_VERSION}/swagger_linux_amd64"
RUN chmod +x /usr/local/bin/swagger
