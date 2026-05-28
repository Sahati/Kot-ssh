FROM wettyoss/wetty:latest

USER root

# Устанавливаем OpenSSH сервер
RUN apk update && apk add --no-cache openssh-server

# Настраиваем SSH: разрешаем вход по паролю и генерируем ключи хоста
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    ssh-keygen -A

# Создаем пользователя 'kot' и задаем ему пароль 'kot'
RUN adduser -D -s /bin/sh kot && \
    echo "kot:kot" | chpasswd

# Создаем скрипт запуска прямо внутри Dockerfile
RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo '/usr/sbin/sshd -p 80' >> /entrypoint.sh && \
    echo 'sleep 2' >> /entrypoint.sh && \
    echo 'exec node index.js --port 3000 --host 0.0.0.0 --title "Kot-ssh" --command "ssh -o StrictHostKeyChecking=no kot@127.0.0.1 -p 80"' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

# Настройка порта для Render
ENV PORT=3000
EXPOSE 3000

# Запускаем наш скрипт
CMD ["/entrypoint.sh"]
