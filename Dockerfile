FROM wettyoss/wetty:latest

# Устанавливаем пароль
RUN echo 'root:tech' | chpasswd

# Говорим Render использовать порт 3000 автоматически
ENV PORT=3000

EXPOSE 3000

CMD ["--port", "3000", "--host", "0.0.0.0", "--command", "login"]
