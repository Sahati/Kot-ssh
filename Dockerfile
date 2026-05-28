FROM wettyoss/wetty:latest

USER root

# Устанавливаем OpenSSH сервер
RUN apk update && apk add --no-cache openssh-server

# Настраиваем SSH: разрешаем вход по паролю и генерируем ключи
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    ssh-keygen -A

# Создаем пользователя 'kot' и задаем ему пароль 'kot'
RUN adduser -D -s /bin/sh kot && \
    echo "kot:kot" | chpasswd

# Переменная порта для Render
ENV PORT=3000
EXPOSE 3000

# Запускаем SSH, спим 3 секунды, затем запускаем Wetty с игнорированием проверки ключей хоста
CMD /usr/sbin/sshd -p 80 && sleep 3 && node index.js --port 3000 --host 0.0.0.0 --title "Kot-ssh" --command "ssh -o StrictHostKeyChecking=no kot@127.0.0.1 -p 80"
