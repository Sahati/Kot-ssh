FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server \
    nodejs \
    npm \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

RUN echo 'root:tech' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN npm install -g wetty

EXPOSE 80

CMD ["wetty", "--port", "80", "--host", "0.0.0.0", "--command", "ssh root@127.0.0.1"]
