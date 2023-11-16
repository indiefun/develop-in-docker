# base image
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

RUN mkdir -p /home/ubuntu/.cache && \
    chown -R ubuntu:ubuntu /home/ubuntu/.cache
VOLUME [ "/home/ubuntu/.cache" ]

RUN mkdir -p /run/sshd
EXPOSE 22

CMD [ "/usr/sbin/sshd", "-D" ]


# feature image
FROM ubuntu as develop

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git curl build-essential

RUN apt-get install -y zsh && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN apt-get install -y postgresql-client

COPY shell /shell
ENV DEBIAN_FRONTEND=noninteractive

ARG TZ=
RUN TZ=${TZ} /shell/install-timezone.sh

ARG NODE_MAJOR=
RUN NODE_MAJOR=${NODE_MAJOR} /shell/install-node.sh

ARG PYTHON_MAJOR=
RUN PYTHON_MAJOR=${PYTHON_MAJOR} /shell/install-python.sh

ARG JDK_MAJOR=
RUN JDK_MAJOR=${JDK_MAJOR} /shell/install-jdk.sh

ARG ODOO_VERSION=
RUN ODOO_VERSION=${ODOO_VERSION} /shell/install-odoo.sh

