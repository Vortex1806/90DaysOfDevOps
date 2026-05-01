# 📘 day-37-revision.md

## ✅ Self-Assessment

- Run container → can do
- Manage containers/images → can do
- Image layers & caching → can do
- Write Dockerfile → can do
- CMD vs ENTRYPOINT → learned and clear
- Build & tag image → can do
- Volumes → can do
- Bind mounts → can do
- Networks → can do
- Docker Compose → can do
- Env variables → can do
- Multi-stage builds → learned and applied
- Push to Docker Hub → can do
- Healthchecks & depends_on → learned and applied

---

## ⚡ Quick-Fire Answers

**Image vs Container**
Image is a blueprint, container is a running instance.

**Data after container removal**
Lost unless stored in volumes.

**Container communication**
Using service/container name over custom network.

**docker compose down vs -v**
-v removes volumes (data loss).

**Multi-stage builds**
Reduce image size by separating build and runtime.

**COPY vs ADD**
COPY is simple; ADD has extra features (extract, URL).

**-p 8080:80**
Maps host port 8080 to container port 80.

**Check Docker disk usage**
docker system df

---

## 🧠 Weak Areas Improved

- CMD vs ENTRYPOINT → now clear with usage patterns
- COPY vs ADD → understood best practices and risks

---

## 🚀 Reflection

This revision helped consolidate Docker fundamentals into practical understanding. I can now confidently build, run, and debug containerized applications, write production-ready Dockerfiles, and orchestrate services using Docker Compose.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
