# Day 33 – Docker Compose: Multi-Container Basics

## ✅ Task 1: Install & Verify

### Check Docker Compose version

```bash
docker compose version
```

---

## ✅ Task 2: First Compose File (Nginx)

### docker-compose.yml

```yaml
services:
  nginx:
    image: nginx:latest
    ports:
      - "8080:80"
```

### Commands

```bash
# Start services
docker compose up

# Start in detached mode
docker compose up -d

# View running services
docker compose ps

# View logs
docker compose logs

# View live logs
docker compose logs -f

# Stop and remove
docker compose down
```

### Access

http://localhost:8080

---

## ✅ Task 3: Two-Container Setup (WordPress + MySQL)

### docker-compose.yml

```yaml
services:
  db:
    image: mysql:8.0
    container_name: mysql-db
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: Test@123
      MYSQL_DATABASE: wordpress
      MYSQL_USER: shubh
      MYSQL_PASSWORD: shubhvora
    volumes:
      - db_data:/var/lib/mysql

  wordpress:
    image: wordpress:latest
    container_name: wordpress
    depends_on:
      - db
    restart: unless-stopped
    ports:
      - "8080:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: shubh
      WORDPRESS_DB_PASSWORD: shubhvora
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wordpress_data:/var/www/html

volumes:
  db_data:
  wordpress_data:
```

### Commands

```bash
# Start services
docker compose up -d

# Check running containers
docker compose ps

# View logs of all services
docker compose logs

# View logs of specific service
docker compose logs wordpress
docker compose logs db

# Follow logs
docker compose logs -f

# Stop services without removing
docker compose stop

# Start again
docker compose start

# Remove everything (containers + networks)
docker compose down

# Remove everything including volumes
docker compose down -v
```

### Verification

- Open http://localhost:8080
- Complete WordPress setup
- Run:

```bash
docker compose down
docker compose up -d
```

- Data persists due to volumes

---

## ✅ Task 4: Compose Commands Summary

```bash
# Start in detached mode
docker compose up -d

# View running services
docker compose ps

# View all logs
docker compose logs

# View logs (live)
docker compose logs -f

# View logs of specific service
docker compose logs <service>

# Stop without removing
docker compose stop

# Remove containers + networks
docker compose down

# Remove everything including volumes
docker compose down -v

# Rebuild images
docker compose up --build

# Rebuild + detached
docker compose up -d --build
```

---

## ✅ Task 5: Environment Variables

### Using .env file

#### .env

```env
MYSQL_ROOT_PASSWORD=Test@123
MYSQL_DATABASE=wordpress
MYSQL_USER=shubh
MYSQL_PASSWORD=shubhvora
```

### docker-compose.yml (updated)

```yaml
services:
  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
```

### Verify variables

```bash
docker compose config
```

---

## 🧠 Key Learnings

- Docker Compose simplifies multi-container setups
- Services communicate using service names
- Volumes persist data across restarts
- `docker compose down -v` removes volumes (data loss)
- Logs help debug multi-container apps

---

## 🚀 Conclusion

Successfully ran:

- Single container (Nginx)
- Multi-container app (WordPress + MySQL)
- Practiced core Docker Compose commands
- Understood networking, volumes, and environment variables
