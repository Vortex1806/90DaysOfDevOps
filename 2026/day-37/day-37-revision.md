## 🐳 Container Commands

- docker run -d -p 8080:80 image → run container in detached mode with port mapping
- docker ps / docker ps -a → list running / all containers
- docker stop <id> → stop container
- docker rm <id> → remove container
- docker exec -it <id> sh → access running container
- docker logs <id> → view logs

## 📦 Image Commands

- docker build -t name:tag . → build image
- docker images → list images
- docker rmi <id> → remove image
- docker pull image → download image
- docker push image → push to Docker Hub
- docker tag img newname → tag image

## 💾 Volume Commands

- docker volume create name → create volume
- docker volume ls → list volumes
- docker volume inspect name → inspect volume
- docker volume rm name → delete volume

## 🌐 Network Commands

- docker network create name → create network
- docker network ls → list networks
- docker network inspect name → inspect network
- docker network connect net container → connect container

## ⚙️ Docker Compose

- docker compose up -d → start services
- docker compose down → stop services
- docker compose ps → list services
- docker compose logs → view logs
- docker compose build → build services

## 🧹 Cleanup

- docker system prune → remove unused data
- docker system df → check disk usage

## 🧱 Dockerfile Instructions

- FROM → base image
- RUN → execute commands during build
- COPY → copy files
- WORKDIR → set working directory
- EXPOSE → document port
- CMD → default command
- ENTRYPOINT → main executable

---
