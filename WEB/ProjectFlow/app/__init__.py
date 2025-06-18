from flask import Flask, request, render_template, redirect, session
import sqlite3
import os
import secrets
import hashlib
from datetime import datetime

def get_db():
    return sqlite3.connect("app/database.db")

def create_app():
    app = Flask(__name__, template_folder=os.path.abspath("templates"))
    app.secret_key = "916cb021458ef661231a5dba9ccc344cf3cb243594f36825669b43073e7f11d9"

    if not os.path.exists("app/database.db"):
        with sqlite3.connect("app/database.db") as conn:
            with open("app/schema.sql") as f:
                conn.executescript(f.read())

    @app.route('/')
    def index():
        return redirect('/register')

    @app.route('/register', methods=['GET', 'POST'])
    def register():
        if request.method == 'POST':
            username = request.form['username']
            password = hashlib.md5(request.form['password'].encode()).hexdigest()

            lowered = username.lower()
            forbidden = ['union', 'like', 'insert', 'update', 'delete', '--', ';']
            for keyword in forbidden:
                if keyword in lowered:
                    return f"Error: The keyword '{keyword}' is not allowed in usernames.", 400

            db = get_db()
            cur = db.execute("SELECT 1 FROM users WHERE username = ?", (username,))
            if cur.fetchone():
                return f"Error: Username '{username}' is already taken.", 400

            db.execute("INSERT INTO users (username, password) VALUES (?, ?)", (username, password))
            db.commit()
            return redirect('/login')
        return render_template('register.html')

    @app.route('/login', methods=['GET', 'POST'])
    def login():
        if request.method == 'POST':
            username = request.form['username']
            password = hashlib.md5(request.form['password'].encode()).hexdigest()
            db = get_db()
            cur = db.execute("SELECT * FROM users WHERE username = ? AND password = ?", (username, password))
            user = cur.fetchone()
            if user:
                session['username'] = username
                return redirect('/dashboard')
            return "Login failed"
        return render_template('login.html')

    @app.route('/dashboard', methods=['GET', 'POST'])
    def dashboard():
        username = session.get('username')
        if not username:
            return redirect('/login')
        db = get_db()

        error = None

        if request.method == 'POST':
            project_name = request.form['project_name']
            db.execute("INSERT INTO projects (username, project_name) VALUES (?, ?)", (username, project_name))
            db.commit()

        # Vulnerable second-order SQLi query reused for both display and exploitation
        query = f"SELECT project_name FROM projects WHERE username = '{username}'"
        print(f"[DEBUG] Executing SQL: {query}", flush=True)
        try:
            cur = db.execute(query)
            projects = [row[0] for row in cur.fetchall()]
            print(f"[DEBUG] Result rows: {projects}", flush=True)
        except Exception as e:
            print(f"[ERROR] SQL error: {e}", flush=True)
            error = "Error"
            projects = []

        total_projects = len(projects)

        return render_template('dashboard.html',
                               username=username,
                               projects=projects,
                               total_projects=total_projects,
                               current_date=datetime.now().strftime("%B %d, %Y"),
                               error=error)

    @app.route('/admin')
    def admin():
        if session.get('username') == 'admin':
            try:
                with open("flag.txt", "r") as f:
                    flag = f.read().strip()
            except:
                flag = "FLAG FILE NOT FOUND"
            return render_template('admin.html', flag=flag)
        return "Access denied"

    @app.route('/logout')
    def logout():
        session.clear()
        return redirect('/login')

    return app
