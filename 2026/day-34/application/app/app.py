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
