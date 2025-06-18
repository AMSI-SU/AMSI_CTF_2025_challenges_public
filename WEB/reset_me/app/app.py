from flask import Flask, render_template, request, redirect, url_for, session, request
import base64
import json
import os
import hmac
import hashlib
from collections import defaultdict
import time

# Paths
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
USERS_FILE = os.path.join(BASE_DIR, "users.json")
TOKENS_FILE = os.path.join(BASE_DIR, "tokens.json")

FLAG = os.environ.get("FLAG", "FLAG{default_placeholder}")
RESET_SECRET = os.environ.get("RESET_SECRET", "default_reset_secret")
DEFAULT_USERS_JSON = os.environ.get("DEFAULT_USERS", None)
DEFAULT_TOKENS_JSON = os.environ.get("DEFAULT_TOKENS", None)


try:
    parsed_default_users = json.loads(DEFAULT_USERS_JSON)
    PROTECTED_USERS = list(parsed_default_users.keys())
except Exception as e:
    print(f"[WARNING] Could not parse DEFAULT_USERS_JSON: {e}")
    PROTECTED_USERS = []
    
    
# os.environ.pop("FLAG", None)
# os.environ.pop("RESET_SECRET", None)
# os.environ.pop("DEFAULT_USERS", None)


if DEFAULT_USERS_JSON and not os.path.exists(USERS_FILE):
    print("[INFO] Création de users.json")
    with open(USERS_FILE, "w") as f:
        f.write(DEFAULT_USERS_JSON)

if not os.path.exists(TOKENS_FILE):
    print("[INFO] Création de tokens.json")
    with open(TOKENS_FILE, "w") as f:
        f.write(DEFAULT_TOKENS_JSON)

# Dictionnaire : {ip: [timestamps]}
login_attempts = defaultdict(list)
MAX_ATTEMPTS = 5
WINDOW_SECONDS = 60

app = Flask(__name__)
# app.secret_key = os.urandom(16)
app.secret_key = b'super_secret_key_035783749780'


def too_many_attempts(ip):
    now = time.time()
    login_attempts[ip] = [ts for ts in login_attempts[ip] if now - ts < WINDOW_SECONDS]
    return len(login_attempts[ip]) >= MAX_ATTEMPTS

def record_attempt(ip):
    login_attempts[ip].append(time.time())

# Load users
def load_users():
    with open(USERS_FILE, 'r') as f:
        return json.load(f)

def save_users(users):
    with open(USERS_FILE, 'w') as f:
        json.dump(users, f)

@app.route("/")
def index():
    return render_template("login.html")

@app.route("/login", methods=["POST"])
def login():
    ip = request.remote_addr
    if too_many_attempts(ip):
        return render_template("login.html", error="Trop de tentatives. Réessaie dans 1 minute 😤")

    users = load_users()
    username = request.form.get("username")
    password = request.form.get("password")

    user = users.get(username)
    if user and user['password'] == password:
        session['username'] = username
        if user.get("is_admin"):
            return render_template("flag.html", flag=FLAG)
        return render_template("dashboard.html", username=username)

    record_attempt(ip)
    return render_template("login.html", error="Nom d’utilisateur ou mot de passe incorrect.")

@app.route("/forgot")
def forgot():
    return render_template("forgot.html")

@app.route("/forgot", methods=["POST"])
def forgot_post():
    ip = request.remote_addr
    if too_many_attempts(ip):
        return render_template("login.html", error="Trop de tentatives. Réessaie dans 1 minute 😤")


    username = request.form.get("username")
    users = load_users()

    if username not in users or username in PROTECTED_USERS:
        return render_template("forgot.html", error="Utilisateur inconnu. T’étais même inscrit ? 😤")

    token = hmac.new(RESET_SECRET.encode(), username.encode(), hashlib.md5).hexdigest()
    print(token)
    # Enregistre le token -> username
    try:
        with open("tokens.json", "r") as f:
            token_db = json.load(f)
    except FileNotFoundError:
        token_db = {}

    token_db[token] = username

    with open("tokens.json", "w") as f:
        json.dump(token_db, f)

    record_attempt(ip)
    reset_link = url_for('reset', token=token, _external=True)
    return render_template("forgot.html", reset_link=reset_link)


@app.route("/reset")
def reset():
    token = request.args.get("token")
    try:
        with open("tokens.json") as f:
            token_db = json.load(f)
            username = token_db.get(token)
    except:
        return "Token invalide"

    if not username:
        return render_template("reset.html", token=None)

    return render_template("reset.html", token=token, username=username)


@app.route("/reset", methods=["POST"])
def reset_post():
    token = request.form.get("token")
    new_password = request.form.get("password")
    try:   
        with open("tokens.json") as f:
            token_db = json.load(f)
        username = token_db.get(token)
    except:
        return "Token invalide"

    if not username:
        return render_template("reset.html", token=None)

    users = load_users()
    if username in users:
        users[username]['password'] = new_password
        save_users(users)
        return redirect(url_for('index'))
    return render_template("reset.html", token=None)


@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")
        users = load_users()

        if username in users:
            return render_template("register.html", error="Ce nom d'utilisateur existe déjà. 😬")
        
        users[username] = {
            "password": password,
            "is_admin": False
        }
        save_users(users)
        return render_template("register.html", success="Ton inscription a été prise en compte 💅 Redirection dans 3 secondes...")

    return render_template("register.html")

@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("index"))

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=3003, debug=True)
