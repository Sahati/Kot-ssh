FROM alpine:latest

RUN apk add --no-cache openssh-server nodejs npm \
    && npm install -g wetty \
    && mkdir /var/run/sshd \
    && echo 'root:tech' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 80

CMD ["wetty", "--port", "80", "--host", "0.0.0.0", "--command", "ssh root@127.0.0.1"]
