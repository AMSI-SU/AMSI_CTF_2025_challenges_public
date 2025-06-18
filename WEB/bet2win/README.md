# Bet2Win – Web Challenge (Hard)

Un challenge web inspiré de l’univers des paris sportifs, avec une belle victoire du PSG 5-0 sur l’Inter Milan comme toile de fond 🏆  
Les joueurs devront faire preuve de curiosité, d’observation, et de maîtrise des commandes shell pour obtenir le flag.

---

## Description 

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

## Déploiement

### Build Docker

```bash
docker build -t bet2win .
docker run --rm -p 5000:5000 --name bet2win_ctf bet2win
```


### Solution (résumé)

En explorant l'application, on découvre une interface assez basique. Mais en analysant les requêtes réseau associées, un fichier script.js attire l’attention : il y fait référence à deux headers spécifiques.

Parmi eux, un particulièrement intrigant : X-BET-STAFF. En testant différentes valeurs (on, 1, oui etc.), on finit par remarquer un comportement différent. Pour aller plus loin, un scan avec Gobuster révèle une route cachée : /staff.

Cette route, visiblement réservée aux employés, donne accès à une interface interne pour générer des cotes via l’endpoint /generate-odds.

En observant les requêtes envoyées à ce dernier, on identifie un paramètre vulnérable : team. Ce paramètre est directement injecté dans un script bash côté serveur, sans aucune validation ou filtrage.

On est donc en présence d’une vulnérabilité de type Command Injection.

Le param 'team' permet d’exécuter des commandes système.

Exploitation

Il suffit d'injecter une commande shell comme suit :

```
;cat /app/flag.txt
```

Le point-virgule termine la commande initiale, `cat /app/flag.txt` affiche le contenu du flag, et `#` commente tout ce qui pourrait suivre.

Et voilà, le flag s’affiche dans la réponse.

Payload final
```
curl -H "X-BET-STAFF: 1" \
"http://localhost:5000/generate-odds?team=psg;cat%20/app/flag.txt%23&form=4-4-2"
```
