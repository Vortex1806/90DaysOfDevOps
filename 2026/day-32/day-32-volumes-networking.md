# Day 32 – Docker Volumes & Networking

## Task 1: The Problem (Data Loss)

### Steps
```bash
# Run MySQL container
docker run -d --name mysql-test \
-e MYSQL_ROOT_PASSWORD=pass123 \
-e MYSQL_DATABASE=testdb mysql

# Enter container
docker exec -it mysql-test mysql -u root -p
```

### Inside MySQL
```sql
CREATE TABLE users (id INT, name VARCHAR(50));
INSERT INTO users VALUES (1, 'Vortex');
SELECT * FROM users;
```

### Remove container
```bash
docker stop mysql-test
docker rm mysql-test
```

### Run again
```bash
docker run -d --name mysql-test \
-e MYSQL_ROOT_PASSWORD=pass123 \
-e MYSQL_DATABASE=testdb mysql
```

### Observation
- Data is LOST ❌

### Why?
- Containers are ephemeral
- Data is stored inside container filesystem
- When container is removed → data is gone

---

## Task 2: Named Volumes

### Create volume
```bash
docker volume create mysql-data
```

### Run container with volume
```bash
docker run -d --name mysql-vol \
-v mysql-data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=pass123 \
-e MYSQL_DATABASE=testdb mysql
```

### Add data (same as before)

### Remove container
```bash
docker stop mysql-vol
docker rm mysql-vol
```

### Run new container with same volume
```bash
docker run -d --name mysql-vol-new \
-v mysql-data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=pass123 \
-e MYSQL_DATABASE=testdb mysql
```

### Observation
- Data is PRESERVED ✅

### Verify
```bash
docker volume ls
docker volume inspect mysql-data
```

### Why?
- Volume stores data outside container lifecycle
- Container can be deleted, data stays

---

## Task 3: Bind Mounts

### Create folder
```bash
mkdir my-site
cd my-site
```

### index.html
```html
<h1>Hello from Bind Mount 🚀</h1>
```

### Run Nginx with bind mount
```bash
docker run -d -p 8080:80 \
-v $(pwd):/usr/share/nginx/html \
--name nginx-bind nginx
```

### Open
http://localhost:8080

### Modify file
Edit index.html → refresh browser → changes visible instantly

### Difference

Named Volume:
- Managed by Docker
- Stored in Docker internal directory
- Best for databases

Bind Mount:
- Direct link to host filesystem
- Changes reflect instantly
- Best for development

---

## Task 4: Docker Networking Basics

### List networks
```bash
docker network ls
```

### Inspect bridge
```bash
docker network inspect bridge
```

### Run containers
```bash
docker run -dit --name c1 ubuntu bash
docker run -dit --name c2 ubuntu bash
```

### Ping by name
```bash
docker exec -it c1 ping c2
```
❌ Fails

### Ping by IP
```bash
docker inspect c2 | grep IPAddress
```

```bash
docker exec -it c1 ping <IP>
```
✅ Works

### Why?
- Default bridge does not provide DNS resolution

---

## Task 5: Custom Networks

### Create network
```bash
docker network create my-app-net
```

### Run containers
```bash
docker run -dit --name c1 --network my-app-net ubuntu bash
docker run -dit --name c2 --network my-app-net ubuntu bash
```

### Ping by name
```bash
docker exec -it c1 ping c2
```
✅ Works

### Why?
- Custom networks have built-in DNS
- Containers resolve each other by name

---

## Task 6: Put It Together

### Create network
```bash
docker network create app-net
```

### Run MySQL with volume
```bash
docker volume create app-data

docker run -d --name mysql-app \
--network app-net \
-v app-data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=pass123 \
-e MYSQL_DATABASE=testdb mysql
```

### Run app container
```bash
docker run -dit --name app --network app-net ubuntu bash
```

### Test connection
```bash
docker exec -it app ping mysql-app
```

✅ Works (name resolution)

---

## Final Understanding

- Containers are ephemeral → use volumes for persistence
- Named volumes = production data
- Bind mounts = development
- Default bridge = limited networking
- Custom network = service-to-service communication
