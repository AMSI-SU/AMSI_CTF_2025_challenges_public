from flask import Flask, request, render_template, abort
import subprocess

# Nouvelle route pour les parieurs : page de mise en paris
from flask import request, render_template, redirect, session
import random

app = Flask(__name__)
app.secret_key = "bet2win-ctf-supersecret-2025"
@app.route("/")
def index():
    return render_template("index.html")

@app.route("/promo")
def promo():
    return render_template("promo.html")

# Route réservée aux staffs, accessible uniquement via le header
@app.route("/staff")
def staff():
    if request.headers.get("X-BET-STAFF") == "1":
        return render_template("staff.html")
    else:
        abort(403, "Accès refusé.")

# Route pour générer les cotes via l'algorithme interne (vulnérable)
@app.route("/generate-odds")
def generate_odds():
    team = request.args.get("team", "")
    form = request.args.get("form", "")
    try:
        cmd = f"python3 ai_engine.py --team {team} --form {form}"
        result = subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        result = e.output
    return f"<pre>{result.decode()}</pre>"



@app.route("/bet", methods=["GET", "POST"])
def bet():
    if request.method == "POST":
        match = request.form.get("match")
        amount = int(request.form.get("amount", 0))

        # (Optionnel) système de solde de session
        if "balance" not in session:
            session["balance"] = 100

        if amount > session["balance"]:
            return "Solde insuffisant !", 400

        # Déduction
        session["balance"] -= amount

        # Gagné ou perdu ?
        result = random.choice(["gagné", "perdu"])
        if result == "gagné":
            session["balance"] += amount * 2  # simple gain x2

        return render_template("bet_result.html", match=match, amount=amount, result=result)

    return render_template("bet.html")


# Nouvelle route pour afficher un classement fictif
@app.route("/leaderboard")
def leaderboard():
    # Données fictives pour le classement
    leaderboard_data = [
        {"user": "Alice", "winnings": 1234},
        {"user": "Bob", "winnings": 1100},
        {"user": "Charlie", "winnings": 900}
    ]
    return render_template("leaderboard.html", leaderboard=leaderboard_data)

# Petite route ping utilisée par le JS (déjà implémentée)
@app.route("/ping")
def ping():
    return {"status": "ok"}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=4015)
