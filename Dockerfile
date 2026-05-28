FROM henrist/wetty

# Устанавливаем пароль для пользователя внутри образа
RUN echo 'root:tech' | chpasswd

# На некоторых версиях нужно разрешить вход по паролю
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config || true

EXPOSE 3000

# Запускаем wetty на порту 3000 (стандарт для этого образа)
CMD ["--port", "3000", "--host", "0.0.0.0", "--command", "login"]
