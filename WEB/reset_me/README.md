
## Description

Bienvenue sur l’ancien portail du BDE 2019, miraculeusement encore en ligne après toutes ces années.  
Le design est dépassé, le code douteux… mais les accès administrateur sont toujours là.

Ton objectif : te connecter en tant qu’admin BDE et récupérer le flag.

**Hint :**

> Un indice s’est peut-être glissé dans les comptes rendus ou au fond d’un vieux dossier … à toi de creuser.


## How to run

```
sudo docker compose up
```


## Writeup

### 1. Reconnaissance initiale

En ouvrant le site, on tombe sur un portail de connexion avec un lien "Mot de passe oublié".  
On teste quelques combinaisons de noms d’utilisateur et mots de passe, mais rien ne fonctionne.  
Une protection contre les tentatives de brute force semble en place, ce qui rend cette approche inefficace.

Le lien "Mot de passe oublié" demande uniquement un nom d’utilisateur, mais aucun utilisateur valide n’est connu à ce stade. Il faut donc en découvrir un.


### 2. Discovery et inscription

Un scan avec Gobuster et une wordlist (`common.txt`) révèle un endpoint `/register`.  
On crée un compte, par exemple `test:test`, et on se connecte.


### 3. Exploration du dashboard

Une fois connecté, on accède à une page contenant plusieurs fichiers :

- `CR_reunion_1.txt`
- `CR_reunion_2.txt`
- `CR_reunion_4.txt`

On remarque que `CR_reunion_3.txt` est absent, ce qui attire l’attention.  
En tentant d’accéder manuellement à ce fichier, on le trouve.  
À l’intérieur, on découvre une clé temporaire, probablement utilisée pour la réinitialisation de mots de passe.

Pour vérifier cela, on tente de réinitialiser le mot de passe de notre propre compte (`test`) via le formulaire "Mot de passe oublié" et on capture le token généré.


En l’analysant (hashid dis que c'est un MD5 probablement), on soupçonne qu’il a été généré à l’aide d’un HMAC avec l’algorithme MD5, en combinant le nom d’utilisateur et la clé secrète.

En testant localement :
```
import hmac, hashlib
hmac.new(key.encode(), username.encode(), hashlib.md5).hexdigest()
```
On obtient le même token. Le mécanisme est donc confirmé.

Il ne reste plus qu’à identifier un compte administrateur existant.
### 4. Énumération des utilisateurs

L’endpoint `/register` indique si un nom d’utilisateur est déjà utilisé. Cela permet d’énumérer les comptes enregistrés.

On teste les classiques (`admin`, `administrator`, `root`, etc.) sans succès.

Dans le fichier `sweats_bde_commandes.csv`, on repère le nom `admin_bde`.  
Mais en le testant dans le formulaire de reset, il est considéré comme inconnu. 

### 5. Réinitialisation du compte admin

En utilisant la clé récupérée dans `CR_reunion_3.txt` et le nom d’utilisateur `admin-bde`, on génère le token de réinitialisation :
```
username = "admin-bde"
key = "clé_obtenue_dans_CR_3"
token = hmac.new(key.encode(), username.encode(), hashlib.md5).hexdigest()
```

On soumet ce token dans le parametre token dans l'URL via le formulaire de reset, on définit un nouveau mot de passe, puis on se connecte avec le compte admin-bde.

Flag obtenu.
