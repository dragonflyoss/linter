# This Dockerfile is used to build an image which is used in circle CI
# to run the the following check or validation:
# markdownlint
# misspell
# ShellCheck
# gometalinter
FROM ubuntu:16.04

# shellcheck is included in this installation command.
RUN apt-get update \
    && apt-get install -y rubygems git curl wget shellcheck \
    && gem install rake \
    && gem install bundler \
    && apt-get clean   

# install golang
# set go binary path to local $PATH
# go binary path is /usr/local/go/bin
ENV GO_VERSION=1.10.4
ENV ARCH=amd64
RUN wget --quiet https://storage.googleapis.com/golang/go${GO_VERSION}.linux-${ARCH}.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-${ARCH}.tar.gz \
    && rm go${GO_VERSION}.linux-${ARCH}.tar.gz
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

# install markdownlint
RUN git clone https://github.com/markdownlint/markdownlint.git \
    && cd markdownlint && git checkout v0.5.0 && rake install

# install gometalinter containing misspell
RUN go get -u github.com/alecthomas/gometalinter && gometalinter --install > /dev/null
