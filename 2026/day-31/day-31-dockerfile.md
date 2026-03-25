# Day 31 – Dockerfile: Build Your Own Images

## Task 1: Your First Dockerfile

### Dockerfile

```Dockerfile
FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl

CMD ["echo", "Hello from my custom image!"]
```

### Commands

```bash
mkdir my-first-image
cd my-first-image

# build image
docker build -t my-ubuntu:v1 .

# run container
docker run my-ubuntu:v1
```

### Output

```
Hello from my custom image!
```

---

## Task 2: Dockerfile Instructions

### Dockerfile

```Dockerfile
FROM ubuntu:latest

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y curl

EXPOSE 8080

CMD ["bash"]
```

### Explanation

- FROM: sets base image
- WORKDIR: sets working directory inside container
- COPY: copies files from host to container
- RUN: executes commands while building image
- EXPOSE: documents the port
- CMD: default command when container starts

---

## Task 3: CMD vs ENTRYPOINT

### CMD (Default Command)

```Dockerfile
FROM ubuntu
CMD ["echo", "hello"]
```

#### Behavior

```bash
docker run cmd-image
# Output: hello

# override CMD completely
docker run cmd-image echo hi
# Output: hi
```

👉 CMD acts as a **default command**.

- If you don’t pass anything → it runs CMD
- If you pass a command → CMD is completely replaced

---

### ENTRYPOINT (Fixed Command)

```Dockerfile
FROM ubuntu
ENTRYPOINT ["echo"]
```

#### Behavior

```bash
docker run entry-image hello
# Output: hello

docker run entry-image hi there
# Output: hi there
```

👉 ENTRYPOINT acts as a **fixed executable**.

- You cannot easily override it
- Whatever you pass becomes arguments to it

---

### CMD + ENTRYPOINT Together (Important)

```Dockerfile
FROM ubuntu
ENTRYPOINT ["echo"]
CMD ["hello"]
```

#### Behavior

```bash
docker run combo-image
# Output: hello

docker run combo-image hi
# Output: hi
```

👉 Here:

- ENTRYPOINT = main command
- CMD = default arguments

---

### When to Use CMD

Use CMD when:

- You want a **default behavior**
- You expect users to override it

✅ Examples:

- Running a script by default
- Starting a dev server

---

### When to Use ENTRYPOINT

Use ENTRYPOINT when:

- You want to **force a specific command**
- Your container behaves like a tool/CLI

✅ Examples:

- A container that always runs `python app.py`
- A utility container like `echo`, `curl`, etc.

---

### When to Use BOTH

Use both when:

- You want a **fixed command + flexible arguments**

👉 Real-world example:

```Dockerfile
ENTRYPOINT ["python", "app.py"]
CMD ["--port", "8000"]
```

```bash
docker run app-image
# runs: python app.py --port 8000

docker run app-image --port 5000
# runs: python app.py --port 5000
```

---

## Task 4: Simple Web App Image

### index.html

```html
<!DOCTYPE html>
<html>
  <head>
    <title>My Docker Website</title>
  </head>
  <body>
    <h1>Hello from Docker Nginx 🚀</h1>
  </body>
</html>
```

### Dockerfile

```Dockerfile
FROM nginx:alpine

COPY index.html /usr/share/nginx/html/
```

### Commands

```bash
docker build -t my-website:v1 .

docker run -d -p 8080:80 my-website:v1
```

Open in browser: http://localhost:8080

---

## Task 5: .dockerignore

### .dockerignore

```
node_modules
.git
*.md
.env
```

### When does this work?

👉 It works during the **build process (docker build)**

Specifically:

- Before Docker executes `COPY . .`
- Docker sends files from your system → to Docker daemon (build context)
- `.dockerignore` filters what gets sent

---

### Important Understanding

Without .dockerignore:

```Dockerfile
COPY . .
```

➡️ Copies EVERYTHING (including node_modules, .git, etc.)

With .dockerignore:

```Dockerfile
COPY . .
```

➡️ Copies ONLY filtered files (ignored files are never sent at all)

---

### Why it matters

- Reduces **build context size**
- Makes builds **faster**
- Avoids leaking sensitive files (.env)
- Keeps images clean

---

## Task 6: Build Optimization

### How Docker Build Works (Core Idea)

Docker builds images in **layers**.
Each instruction creates a layer:

- FROM
- RUN
- COPY
- etc.

👉 These layers are **cached**.

---

### Example of Caching

```Dockerfile
FROM node:18

COPY package.json .
RUN npm install

COPY . .
```

#### First Build

- All steps run

#### Second Build (no changes)

- All layers reused (fast)

#### Change a file in project

- Only `COPY . .` layer rebuilds
- `npm install` is reused (fast)

---

### Bad Dockerfile (Slow Builds)

```Dockerfile
COPY . .
RUN npm install
```

❌ Problem:

- Any code change invalidates COPY
- npm install runs again every time (slow)

---

### Good Dockerfile (Optimized)

```Dockerfile
COPY package.json .
RUN npm install
COPY . .
```

✅ Benefit:

- Dependencies install only when package.json changes
- Code changes don’t trigger reinstall

---

### Key Rule

👉 **Put frequently changing layers at the bottom**
👉 **Put stable layers at the top**

---

### Real Insight (Very Important)

Docker cache breaks when:

- File content changes
- Order of instructions changes

So:

- Even small changes can trigger rebuilds
- Proper ordering = huge time savings in CI/CD

---

### Why Layer Order Matters

- Saves build time (seconds → minutes in real projects)
- Reduces compute cost in CI pipelines
- Makes developer workflow faster

---

## Final Notes

- Dockerfiles define reproducible environments
- Layer caching is key to performance
- CMD vs ENTRYPOINT is about flexibility vs control

---
