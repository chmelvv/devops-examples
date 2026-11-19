cd django
# prepare the Django project
docker run --rm    -v "${PWD}:/app" -w /app python:3.10-slim bash   -c "pip install Django==4.2 && django-admin startproject mydjango ."

# 1. Збираємо перший образ (Django)
docker build -t my-django:1.0 ./django

# 2. Збираємо другий образ (Nginx)
docker build -t my-nginx:1.0 ./nginx

# 3. Створюємо спільну внутрішню мережу вручну (DHCP, DNS сервера)
docker network create my-project-net

# 4. Запускаємо базу даних у цій мережі під іменем "db"
docker run -d --name db --network my-project-net2 --env-file test.env postgres:14

# 5. Запускаємо Django у цій же мережі під іменем "django"
docker run -d --name django --network my-project-net2 --env-file test.env my-django:1.0

# 6. Запускаємо Nginx у цій же мережі та відкриваємо 80-й порт назовні
docker run -d --name nginx --network my-project-net2 -p 80:80 my-nginx:1.0