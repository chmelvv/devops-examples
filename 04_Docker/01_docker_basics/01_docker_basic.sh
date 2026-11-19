docker run hello-world

#docker pull nginx:latest ?
#docker pull nginx:stable ?
#google: docker hub nginx
docker pull nginx:1.30.7
docker images

docker run -d -p 8080:80 --name my-nginx nginx:1.30.7

# Перевіряємо, що контейнер працює (прапорець -a покаже і зупинені)
docker ps
docker ps -a

# Заходимо в термінал працюючого контейнера (-it — інтерактивний режим із терміналом)
docker exec -it my-nginx bash

# --- Команди всередині контейнера ---
ls -la /usr/share/nginx/html                                      # Дивимося файли сайту
echo "<h1>Hello from Container!</h1>" > /usr/share/nginx/html/index.html  # Перезаписуємо index.html
exit                                                              # Виходимо з контейнера на хост
# ------------------------------------
# -> Оновлюємо http://localhost:8080 у браузері — заголовок змінився!

# Альтернатива: підміна файлу без входу всередину (копіювання з хоста в контейнер)
#scp analog:
docker cp ./www/index.html my-nginx:/usr/share/nginx/html/index.html

# 3. ПІД'ЄДНАННЯ ЛОКАЛЬНОЇ ПАПКИ / ДИСКА (BIND MOUNT / VOLUMES)
# ==============================================================================

# Зупиняємо та видаляємо попередній контейнер, щоб звільнити ім'я та порт 8080
docker stop my-nginx && docker rm my-nginx

# Створюємо папку на нашому комп'ютері та кладемо туди свій сайт
docker run -d \
    -p 8080:80 \
    --name my-nginx \
    -v "C:/Users/vikto/Documents/Neoversity/Examples/04_Docker/www:/usr/share/nginx/html" \
    nginx:1.30.7

# 4. ЗБЕРЕЖЕННЯ КОНТЕЙНЕРА ЯК ОБРАЗУ ТА ПУБЛІКАЦІЯ НА DOCKER HUB
# ==============================================================================

# Повернемося до контейнера зі зміненим файлом усередині (бо папка -v не вшивається в образ)
docker stop my-nginx && docker rm my-nginx
docker run -d -p 8080:80 --name custom-nginx nginx:1.30.7
docker exec custom-nginx bash -c "echo '<h1>My Custom Image v1.0</h1>' > /usr/share/nginx/html/index.html"

# Фіксуємо стан зміненого контейнера у новий локальний образ (замініть YOUR_LOGIN на ваш логін Docker Hub)
docker commit custom-nginx chmelvv/my-custom-nginx:1.0

# Перевіряємо, що новий образ з'явився в списку
docker images

# Авторизуємося на Docker Hub (попросить ввести логін та пароль/токен)
docker login

# Відправляємо (публікуємо) наш новий образ у свій репозиторій на Docker Hub
docker push chmelvv/my-custom-nginx:1.0

# 5. ОЧИЩЕННЯ СИСТЕМИ ПІСЛЯ ЗАНЯТТЯ
# ==============================================================================

# Зупиняємо та видаляємо контейнер
docker stop custom-nginx
docker rm custom-nginx

# Видаляємо локальні образи (якщо потрібно очистити диск)
docker rmi chmelvv/my-custom-nginx:1.0 nginx:1.30.7