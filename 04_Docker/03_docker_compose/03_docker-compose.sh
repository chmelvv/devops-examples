# 1. Збираємо обидва образи (django та nginx) і запускаємо всі 3 контейнери у фоні
docker compose up -d --build

# 2. Перевіряємо, що всі 3 сервіси у статусі Up (Running)
docker compose ps

# 3. Застосовуємо початкові міграції Django, щоб створити таблиці в PostgreSQL
docker compose exec django python manage.py migrate

# 4. (Опціонально) Перевіряємо логи Django, щоб переконатися у відсутності помилок підключення до БД
docker compose logs django

#Where is db?
docker volume ls

#logs
docker compose logs django
docker compose up -d