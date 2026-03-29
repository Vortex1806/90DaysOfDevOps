# Day 34 – Docker Compose: Real-World Multi-Container Apps

## 🚀 Overview

Today’s goal was to move beyond basic Docker Compose and build a **production-like multi-container system** with:

- Web application
- Database
- Cache
- Healthchecks
- Restart policies
- Custom Dockerfiles
- Scaling

---

## ✅ Task 1: 3-Service Application Stack

### Architecture

```
Browser → Flask App → Postgres
                     → Redis
```

### docker-compose.yml

```yaml
version: "3.9"

services:
  web:
    build: ./app
    ports:
      - "5000:5000"
    depends_on:
      db:
        condition: service_healthy
    networks:
      - app2-network

  db:
    image: postgres:15
    environment:
      POSTGRES_DB: testdb
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - db_data:/var/lib/postgresql/data
    restart: always
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]
      interval: 5s
      timeout: 5s
      retries: 5
    networks:
      - app2-network

  cache:
    image: redis:latest
    networks:
      - app2-network

volumes:
  db_data:

networks:
  app2-network:
```

---

## 🧱 Web App Setup

### app.py

```python
from flask import Flask
import psycopg2
import redis
import time

app = Flask(__name__)


def get_db_connection():
    while True:
        try:
            conn = psycopg2.connect(
                host="db",
                database="testdb",
                user="user",
                password="password"
            )
            return conn
        except:
            print("Waiting for DB...")
            time.sleep(2)


@app.route("/")
def home():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT NOW();")
    result = cur.fetchone()
    cur.close()
    conn.close()

    r = redis.Redis(host="cache", port=6379)
    r.set("msg", "Hello from Redis!")

    return f"DB Time: {result}, Cache: {r.get('msg').decode()}"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

---

### requirements.txt

```
flask
psycopg2-binary
redis
```

---

### Dockerfile

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "app.py"]
```

---

## ▶️ Running the Application

```bash
# Build and start
docker compose up --build

# Run in detached mode
docker compose up -d

# View running services
docker compose ps

# View logs of all services
docker compose logs

# Follow logs
docker compose logs -f

# Logs of specific service
docker compose logs web
docker compose logs db

# Stop without removing
docker compose stop

# Start again
docker compose start

# Remove containers + networks
docker compose down

# Remove everything including volumes
docker compose down -v
```

---

## ✅ Task 2: depends_on & Healthchecks

- Used `depends_on` with `condition: service_healthy`
- Database waits until ready using `pg_isready`

### Key Learning

- `depends_on` alone is NOT enough
- Healthchecks ensure the service is actually ready

---

## ✅ Task 3: Restart Policies

### Config

```yaml
restart: always
```

### Test

```bash
docker kill <db_container_id>
```

### Observation

- Container did NOT restart after manual kill

### Why?

- Restart policies handle failures, not manual user actions

### Comparison

| Policy     | Behavior                            |
| ---------- | ----------------------------------- |
| always     | Restarts on crash or daemon restart |
| on-failure | Restarts only on non-zero exit      |

### When to use

- `always` → databases, critical systems
- `on-failure` → apps where crash detection matters

---

## ✅ Task 4: Custom Dockerfiles

- Used `build: ./app`
- Modified app code
- Rebuilt using:

```bash
docker compose up --build
```

---

## ✅ Task 5: Networks & Volumes

### Named Volume

```yaml
volumes:
  db_data:
```

### Named Network

```yaml
networks:
  app2-network:
```

### Learning

- Volumes persist database data
- Networks allow service communication via names (`db`, `cache`)

---

## ✅ Task 6: Scaling (Bonus)

### Command

```bash
docker compose up --scale web=3
```

### Result

- Scaling failed due to port conflict

### Why?

- Multiple containers cannot bind to same host port

### Key Learning

> Scaling requires a load balancer (e.g., Nginx) instead of direct port mapping

---

## 🧠 Key Learnings

- Multi-container apps using Docker Compose
- Service communication via DNS (service names)
- Healthchecks for production readiness
- Restart policies for resilience
- Custom Docker images using Dockerfile
- Named volumes for persistence
- Scaling limitations and need for load balancing

---

## 🚀 Conclusion

Successfully built a **real-world multi-container application** with:

- Flask web app
- Postgres database
- Redis cache

Learned core concepts required for:

- Microservices architecture
- Production deployments
- System reliability and debugging
