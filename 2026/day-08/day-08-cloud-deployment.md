<img width="1440" height="332" alt="Screenshot 2026-02-23 at 9 21 59 PM" src="https://github.com/user-attachments/assets/01d5d81e-5a28-49b2-b522-000058e14767" /><img width="1440" height="390" alt="Screenshot 2026-02-23 at 9 21 11 PM" src="https://github.com/user-attachments/assets/a985cac6-368f-4b42-9db8-5007071c2c96" /><img width="1440" height="900" alt="Screenshot 2026-02-23 at 9 20 49 PM" src="https://github.com/user-attachments/assets/de6e4315-955a-4d3f-9e37-c34b742bcfc3" /><img width="1440" height="900" alt="Screenshot 2026-02-23 at 9 20 20 PM" src="https://github.com/user-attachments/assets/0696c46e-77df-43ea-aef2-0fec5b0ef4b1" /><img width="1440" height="900" alt="Screenshot 2026-02-23 at 9 18 23 PM" src="https://github.com/user-attachments/assets/80af9edb-6bba-4a16-b118-222bba8712cd" /><img width="1440" height="900" alt="Screenshot 2026-02-23 at 9 17 28 PM" src="https://github.com/user-attachments/assets/cac4bd37-d423-4708-af53-f49249834822" /><img width="1440" height="900" alt="Screenshot 2026-02-23 at 9 14 12 PM" src="https://github.com/user-attachments/assets/c35d536f-7184-44c4-8eac-89cf73cdcf07" /># Day 08 – Cloud Server Setup: Docker, Nginx & Web Deployment

## Commands Used

<img width="1440" height="773" alt="Screenshot 2026-02-23 at 9 12 51 PM" src="https://github.com/user-attachments/assets/45da650c-457e-4620-8216-c0916a9498f0" />

### Launch Instance & Connect via SSH
```bash
ssh -i "devils.pem" ubuntu@ec2-65-0-12-99.ap-south-1.compute.amazonaws.com
```
![Uploading Screenshot 2026-02-23 at 9.14.12 PM.png…](ssh done into the machine)

### Update System
```bash
sudo apt update
sudo apt upgrade -y
```

### Install Docker
```bash
sudo apt install docker.io -y
sudo systemctl status docker
sudo systemctl start docker
sudo systemctl enable docker
docker --version
```
![Uploading Screenshot 2026-02-23 at 9.17.28 PM.png…](Docker installed)

### Install Nginx
```bash
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
```
![Uploading Screenshot 2026-02-23 at 9.18.23 PM.png…](NGINX installed)

![Uploading Screenshot 2026-02-23 at 9.20.20 PM.png…](Enabled port access)


![Uploading Screenshot 2026-02-23 at 9.20.49 PM.png…](Welcome to nginx)


### View Nginx Logs
```bash
cd /var/log/nginx
ls
sudo cat access.log
```
![Uploading Screenshot 2026-02-23 at 9.21.11 PM.png…](logs here)


### Save Logs to File
```bash
sudo cp /var/log/nginx/access.log ~/nginx-logs.txt
```
![Uploading Screenshot 2026-02-23 at 9.21.59 PM.png…](Copied and checked logs)

### Download Log File to Local Machine
```bash
scp -i "devils.pem" ubuntu@ec2-65-0-12-99.ap-south-1.compute.amazonaws.com:~/nginxlogs.txt .
```
<img width="1440" height="195" alt="Screenshot 2026-02-23 at 9 25 46 PM" src="https://github.com/user-attachments/assets/06abbd04-8334-4737-88d5-5cc6e94ed224" />

---

## What I Learned

- How to provision and access a cloud server using SSH.
- How to install and manage services using systemctl.
- How security groups control inbound traffic.
- How to access and extract logs from a production server.
- Basic container deployment using Docker.

---

## Additional Learnings

- Understood the difference between `systemctl start` (starts the service immediately for the current session) and `systemctl enable` (ensures the service starts automatically on system boot).
- Learned how to read and decode CLI usage help messages such as the `scp` usage output to understand required arguments (`source` and `target`) and optional flags.
- Gained clarity on proper `scp` command structure:

```bash
scp -i my-key.pem ubuntu@<your-instance-ip>:~/nginx-logs.txt .
```

Where:
- `-i` specifies the identity (private key) file
- `source` is the remote file path
- `.` represents the current local directory (target)



