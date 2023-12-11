# Use Ubuntu as the base image
FROM ubuntu:22.04

# Install essential dependencies
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  curl \
  build-essential \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  libyaml-dev \
  libsqlite3-dev \
  libxml2-dev \
  libxslt1-dev \
  openssl \
  libcurl4-openssl-dev \
  libffi-dev \
  # zlibc \
  ruby-dev \
  sqlite3 \ 
  wget \
  git \
  bash \
  rbenv

# Run SSH
RUN apt-get install -y openssh-server && \
  mkdir /var/run/sshd && \
  echo 'root:password' | chpasswd && \
  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Install bosh dependencies
# RUN wget http://archive.ubuntu.com/ubuntu/pool/main/r/readline6/libreadline6_6.3-8ubuntu2_amd64.deb \
#   && wget http://archive.ubuntu.com/ubuntu/pool/main/r/readline6/libreadline6-dev_6.3-8ubuntu2_amd64.deb \
#   && dpkg -i libreadline6_6.3-8ubuntu2_amd64.deb \
#   && dpkg -i libreadline6-dev_6.3-8ubuntu2_amd64.deb

# Install Ruby using rbenv
RUN exec bash \
  && rbenv init \
  && rbenv install 3.0.2 \
  && rbenv global 3.0.2

RUN gem install bundler

RUN wget -O bosh https://github.com/cloudfoundry/bosh-cli/releases/download/v7.5.0/bosh-cli-7.5.0-linux-amd64 \
  && chmod +x ./bosh \
  && mv ./bosh /usr/local/bin/bosh


RUN git clone https://github.com/bosh-packages/ruby-release /root/ruby-release
# Set the working directory
WORKDIR /root/app

# Copy your project files into the container
COPY . /root/app


RUN bosh vendor-package ruby-2.7 /root/ruby-release
# Define environment variables, if needed
# ENV EXAMPLE_VAR=value

# Command to run when the container starts
CMD ["bash"]
