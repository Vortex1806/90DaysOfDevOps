# Day 29 – Docker Basics

## Task 1: What is Docker?

### What is a Container?

A container is a lightweight, portable unit that packages an application along with its dependencies, libraries, and configuration. It ensures that the application runs consistently across different environments.

### Why do we need containers?

- Eliminates "it works on my machine" problem
- Lightweight compared to virtual machines
- Faster startup time
- Easy to scale and deploy

### Containers vs Virtual Machines

| Feature     | Containers    | Virtual Machines    |
| ----------- | ------------- | ------------------- |
| OS          | Share host OS | Each has its own OS |
| Size        | Lightweight   | Heavy               |
| Startup     | Fast          | Slow                |
| Performance | High          | Moderate            |
| Isolation   | Process-level | Full OS-level       |

### Docker Architecture

Docker uses a client-server architecture:

- Docker Client: CLI where we run commands (docker run, docker ps)
- Docker Daemon: Background service that manages containers
- Docker Images: Read-only templates to create containers
- Docker Containers: Running instances of images
- Docker Registry: Stores images (Docker Hub)

### Architecture Description

When you run a command like `docker run nginx`, the Docker client sends the request to the Docker daemon. The daemon pulls the nginx image from Docker Hub (if not present locally) and creates a container from it. Then the container starts running.

---

## Task 2: Install Docker

### Installation

Installed Docker using official documentation.

### Verify Installation

```bash
docker --version
```

### Run Hello World

```bash
docker run hello-world
```

### Output Explanation

- Docker checks for image locally
- If not found, pulls from Docker Hub
- Creates container
- Runs it and prints message

---

## Task 3: Run Real Containers

### Run Nginx

```bash
docker run -d -p 8080:80 nginx
```

Access in browser: http://localhost:8080

### Run Ubuntu Interactive

```bash
docker run -it ubuntu bash
```

### List Running Containers

```bash
docker ps
```

### List All Containers

```bash
docker ps -a
```

### Stop Container

```bash
docker stop <container_id>
```

### Remove Container

```bash
docker rm <container_id>
```

---

## Task 4: Explore

### Detached Mode

```bash
docker run -d nginx
```

Runs container in background

### Custom Name

```bash
docker run -d --name my-nginx nginx
```

### Port Mapping

```bash
docker run -d -p 3000:80 nginx
```

### Check Logs

```bash
docker logs <container_id>
```

### Execute Command in Running Container

```bash
docker exec -it <container_id> bash
```

---

## Learnings

- Understood containers and Docker basics
- Ran first containers
- Learned key Docker commands
- Explored container lifecycle
