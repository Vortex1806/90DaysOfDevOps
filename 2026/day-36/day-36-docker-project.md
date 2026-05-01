# 🚀 Day 36 – Docker Project: Dockerize a Full Application

## 📌 Project Overview
For Day 36, I Dockerized a **Flask + MongoDB Notes Application**.

The app is a simple backend service that allows storing and retrieving notes using a MongoDB database. It demonstrates how a backend service communicates with a database inside a containerized environment.

---

## 🧠 Why This App?
- Covers backend + database integration
- Demonstrates Docker networking between services
- Uses volumes for persistence
- Represents a real-world microservice setup

---

## 🐳 Dockerfile (Multi-Stage Build)

```dockerfile
# Stage 1: Builder
FROM python:3-alpine AS builder

WORKDIR /app

# Install dependencies
COPY app/requirements.txt requirements.txt
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Copy application code
COPY . .

# Stage 2: Runtime (minimal image)
FROM gcr.io/distroless/python3

WORKDIR /app

# Copy dependencies from builder
COPY --from=builder /install /usr/local

# Copy app source code
COPY --from=builder /app .

# Run the application
CMD ["app/app.py"]
```

---

## ⚙️ Docker Compose Setup

```yaml
services:
  mongo-server:
    image: mongo:latest
    networks:
      - devnotes-net
    volumes:
      - mongo-data:/data/db
    healthcheck:
      test: ["CMD", "mongosh", "--eval", "db.adminCommand('ping').ok", "--quiet"]
      interval: 30s
      timeout: 5s
      retries: 3
      start_period: 30s

  devnotes-backend:
    image: shubh1840/devnotes-backend:latest
    ports:
      - "5000:5000"
    environment:
      - MONGO_URI=mongodb://mongo-server:27017
    networks:
      - devnotes-net
    depends_on:
      mongo-server:
        condition: service_healthy
    healthcheck:
      test: ["CMD-SHELL", "wget -qO- http://localhost:5000/ || exit 1"]
      interval: 30s
      timeout: 5s
      retries: 2
      start_period: 30s

networks:
  devnotes-net:

volumes:
  mongo-data:
```

---

## 🧪 How to Run

```bash
docker compose up --build
```

Access the app at:
```
http://localhost:5000
```

---

## 🧩 Challenges Faced

### 1. ModuleNotFoundError (Flask not found)
**Issue:** Dependencies were not available inside the container.

**Fix:** Installed dependencies properly in builder stage and copied them into runtime.

---

### 2. Minimal Image Issues (Distroless)
**Issue:** No shell available for debugging.

**Fix:** Ensured everything works in builder stage before copying to runtime.

---

### 3. MongoDB Connection Timing
**Issue:** Backend started before MongoDB was ready.

**Fix:** Added healthcheck and depends_on with condition: service_healthy.

---

### 4. Container Communication
**Issue:** Services could not connect initially.

**Fix:** Used custom Docker network and service name (mongo-server) as hostname.

---

## 📦 Final Image
- Image Name: shubh1840/devnotes-backend
- Tag: latest
- Docker Hub: https://hub.docker.com/repository/docker/shubh1840/devnotes-backend

---

## 🔗 Project Repository
GitHub: https://github.com/Vortex1806/devnotes-backend/

---

## ✅ Test (Fresh Run)
- Removed all containers and images
- Pulled image from Docker Hub
- Ran docker compose up
- Application started successfully
- Database persisted data using volume

---

## 📚 Key Learnings
- Multi-stage Docker builds for smaller images
- Using distroless images for production
- Service orchestration with Docker Compose
- Healthchecks and dependency management
- Container networking and environment variables

---

## 🚀 Conclusion
This project simulates a real backend deployment workflow. It helped me understand how to package, run, and orchestrate services using Docker and Docker Compose in a production-like setup.

---

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham