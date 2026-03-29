# Day 35 – Multi-Stage Builds & Docker Hub

## 🚀 Overview

Today’s objective was to understand how to build **optimized Docker images using multi-stage builds** and distribute them via Docker Hub.

This exercise focused on:

- Reducing image size
- Improving security
- Understanding Docker layers and caching
- Handling real-world errors
- Publishing images

🔗 Docker Hub Repo: https://hub.docker.com/repository/docker/shubh1840/multimon/

---

## ✅ Task 1: Problem with Large Images

### Initial Setup

Created a simple Node.js app.

### ❌ Single Stage Dockerfile

```dockerfile
FROM node:18

WORKDIR /app

COPY . .

RUN npm install

CMD ["node", "app.js"]
```

### Build

```bash
docker build -t multimon:v1 .
docker images
```

### 📊 Image Size

```
~1.09 GB
```

---

## ❗ Issues Observed

- Huge image size
- Contains unnecessary build tools
- Copies everything (including unwanted files)
- Slow build and deployment

---

## ✅ Task 2: Multi-Stage Build

### Optimized Dockerfile

```dockerfile
# Stage 1: Builder
FROM node:18 AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .

# Stage 2: Runtime
FROM gcr.io/distroless/nodejs18

WORKDIR /app

COPY --from=builder /app .

CMD ["app.js"]
```

---

### 📊 Image Size Comparison

```
Before: 1.09 GB
After (Alpine): ~127 MB
After (Distroless): ~115 MB
Reduction: ~90%
```

---

## 🧠 Key Concepts Learned

### 1. Multi-Stage Builds

- Separate build and runtime environments
- Only copy required artifacts

### 2. Layer Caching Optimization

```dockerfile
COPY package*.json ./
RUN npm install
COPY . .
```

- Prevents reinstalling dependencies on every change

### 3. Distroless Images

- No shell, no package manager
- Minimal attack surface
- Smaller and more secure

---

## ⚠️ Issues Faced & Fixes

### 1. ❌ Dockerfile Parse Error

```
unknown instruction: pip
```

✔ Fix: Use `RUN` before commands

---

### 2. ❌ Distroless Build Failure

```
/bin/sh: no such file or directory
```

Cause: Tried to run `RUN adduser` in distroless

✔ Fix:

- Distroless has no shell
- Perform setup in builder stage
- Remove RUN commands in final stage

---

### 3. ❌ Wrong CMD in Distroless

```
CMD ["node", "app.js"]
```

✔ Fix:

```
CMD ["app.js"]
```

Reason: Distroless already includes node runtime

---

### 4. ❌ Unnecessary File Copy

```
COPY . .
```

✔ Fix: Add `.dockerignore`

---

### 5. ❌ Restart Policy Misunderstanding

- `docker kill` does not trigger restart
- Restart policies only handle failures

---

## ✅ Task 3: Push to Docker Hub

### Login

```bash
docker login
```

### Tag Image

```bash
docker tag multimon:v3 shubh1840/multimon:v1
```

### Push Image

```bash
docker push shubh1840/multimon:v1
```

### Verify

```bash
docker rmi multimon:v3
docker pull shubh1840/multimon:v1
```

---

## 🧠 Docker Hub Learnings

- Repository created successfully
- Tags represent versions

### Commands

```bash
docker pull shubh1840/multimon:v1
docker pull shubh1840/multimon:latest
```

### Observations

- `latest` is default
- Version tags provide stability

---

## ✅ Task 4: Best Practices Applied

### ✔ Minimal Base Image

Used distroless instead of full Node image

### ✔ Non-root User

Distroless runs as non-root by default

### ✔ Optimized Layers

```dockerfile
RUN npm ci --only=production
```

### ✔ .dockerignore

```
node_modules
.git
Dockerfile
README.md
```

### ✔ Specific Tag Usage

Avoid using `latest` in production

---

## 📊 Final Results

| Version                  | Image Size |
| ------------------------ | ---------- |
| Single Stage             | ~1.09 GB   |
| Multi-stage (Alpine)     | ~127 MB    |
| Multi-stage (Distroless) | ~115 MB    |

---

## 🧠 Edge Cases & Insights

- Distroless images cannot run shell commands
- Manual container kill does not trigger restart policies
- Copy order affects caching and build time
- Scaling fails with fixed port mapping
- Dockerfile is not a shell script

---

## 🚀 Conclusion

This exercise demonstrated:

- How to drastically reduce image size (~90%)
- How multi-stage builds separate concerns
- How to build secure production-ready images
- How to distribute images via Docker Hub

This workflow reflects **real-world DevOps practices** used in production systems.
