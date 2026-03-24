# Day 30 – Docker Images & Container Lifecycle

## Task 1: Docker Images

### Pull Images

```bash
docker pull nginx
docker pull ubuntu
docker pull alpine
```

### List Images

```bash
docker images
```

### Sample Output

```
REPOSITORY   TAG       IMAGE ID       SIZE
nginx        latest    abc123         187MB
ubuntu       latest    def456         77MB
alpine       latest    ghi789         7MB
```

### Why Alpine is Smaller?

- Alpine uses a minimal Linux distribution
- Uses musl libc instead of glibc
- No extra packages → very lightweight

### Inspect Image

```bash
docker inspect nginx
```

### Output (Important Fields)

- Id
- Created
- Architecture
- OS
- Layers

### Remove Image

```bash
docker rmi alpine
```

---

## Task 2: Image Layers

### View Layers

```bash
docker image history nginx
```

### Sample Output

```
IMAGE          CREATED        CREATED BY                  SIZE
abc123         2 weeks ago    /bin/sh -c #(nop) CMD...    0B
xyz456         2 weeks ago    /bin/sh -c apt-get install  50MB
lmn789         2 weeks ago    /bin/sh -c #(nop) ADD...    100MB
```

### What are Layers?

- Each instruction in Dockerfile creates a layer
- Layers are cached → speeds up builds
- Shared across images → saves space

### Why Some Layers are 0B?

- Metadata changes (CMD, ENV) don’t add file size

---

## Task 3: Container Lifecycle

### Create Container (not running)

```bash
docker create --name lifecycle-test nginx
```

### Start

```bash
docker start lifecycle-test
```

### Pause

```bash
docker pause lifecycle-test
```

### Unpause

```bash
docker unpause lifecycle-test
```

### Stop

```bash
docker stop lifecycle-test
```

### Restart

```bash
docker restart lifecycle-test
```

### Kill

```bash
docker kill lifecycle-test
```

### Remove

```bash
docker rm lifecycle-test
```

### Observe States

```bash
docker ps -a
```

States:

- Created
- Running
- Paused
- Exited

---

## Task 4: Working with Running Containers

### Run Nginx Detached

```bash
docker run -d --name nginx-test -p 8080:80 nginx
```

### View Logs

```bash
docker logs nginx-test
```

### Follow Logs

```bash
docker logs -f nginx-test
```

### Exec into Container

```bash
docker exec -it nginx-test bash
```

### Run Command without Entering

```bash
docker exec nginx-test ls /usr/share/nginx/html
```

### Inspect Container

```bash
docker inspect nginx-test
```

### Important Output Fields

- IPAddress
- Ports
- Mounts

---

## Task 5: Cleanup

### Stop All Running Containers

```bash
docker stop $(docker ps -q)
```

### Remove All Stopped Containers

```bash
docker rm $(docker ps -a -q)
```

### Remove Unused Images

```bash
docker image prune -a
```

### Check Disk Usage

```bash
docker system df
```

---

## Key Learnings

- Images are blueprints, containers are running instances
- Layers make Docker efficient and fast
- Alpine is preferred for lightweight containers
- Containers have a full lifecycle with multiple states
- Logs and exec are critical for debugging
- Cleanup is important to save disk space
