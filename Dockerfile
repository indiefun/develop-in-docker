# base image: ubuntu
FROM ubuntu:22.04 AS ubuntu

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo openssh-server

RUN useradd -m -d /home/ubuntu -s /bin/bash -G sudo ubuntu
RUN sed -i 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD:ALL/g' /etc/sudoers
WORKDIR /home/ubuntu

ARG AUTHORIZED_KEYS=
RUN mkdir -p /home/ubuntu/.ssh && \
    echo "${AUTHORIZED_KEYS}" > /home/ubuntu/.ssh/authorized_keys && \
    chown -R ubuntu:ubuntu /home/ubuntu/.ssh && \
    chmod -R 0700 /home/ubuntu/.ssh
VOLUME [ "/home/ubuntu/.ssh" ]

RUN mkdir -p /run/sshd
EXPOSE 22

CMD [ "/usr/sbin/sshd", "-D" ]


# feature image
FROM ubuntu as develop

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

RUN apt-get install -y zsh && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ARG NODE_MAJOR=20
RUN apt-get install -y ca-certificates curl gnupg && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y nodejs
RUN npm install -g npm yarn

RUN apt-get install -y python3 python3-pip && \
    pip3 install --upgrade pip
