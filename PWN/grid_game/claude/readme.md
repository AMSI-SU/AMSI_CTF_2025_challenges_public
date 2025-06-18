# 🎮 Jeu Multijoueur Terminal - Conquête de Cases

Un jeu multijoueur en C jouable dans le terminal où 4 joueurs s'affrontent pour conquérir le plus de cases sur un plateau 8x8.

## 🚀 Installation et Compilation

### Prérequis
- **GCC** (compilateur C)
- **pthread** (bibliothèque de threads)
- **mpv** (optionnel, pour la musique)

```bash
# Vérifier les dépendances
make install-deps

# Compiler le serveur et le client
make all
```

## 🎯 Comment Jouer

### 1. Lancer le Serveur
```bash
./game_server <port>
# Exemple:
./game_server 8080
```

### 2. Lancer les Clients (jusqu'à 4 joueurs)
```bash
./game_client
```

### 3. Se connecter au Serveur
Dans le client, tapez :
```
connect <adresse> <port>
# Exemples:
connect localhost 8080
connect 192.168.1.100 8080
```

## 🎮 Règles du Jeu

### Objectif
Conquérir le plus de cases possible et bloquer les autres joueurs !

### Déroulement
1. **4 joueurs maximum** représentés par : `@`, `&`, `X`, `#`
2. **Plateau 8x8** avec cases numérotées de 0 à 7
3. Chaque joueur commence avec **1 case aléatoire**
4. **Tour par tour**, chaque joueur achète une case adjacente
5. **Vision limitée** : vous ne voyez que les cases à distance 1 de vos possessions
6. Les cases inconnues apparaissent comme `?`

### Contraintes
- ✅ On peut acheter uniquement les cases **adjacentes** aux siennes
- ❌ On ne peut pas acheter une case déjà possédée
- ❌ Ce n'est possible que pendant son tour

## 📋 Commandes Disponibles

### Avant Connexion
- `connect <adresse> <port>` - Se connecter au serveur
- `help` - Afficher l'aide
- `quit` - Quitter

### Pendant le Jeu
- `$play` - Lancer la partie
- `$buy <x> <y>` - Acheter une case (ex: `$buy 3 2`)
- `$list_players` - Voir la liste des joueurs
- `$music_on` - Activer la musique (mus1k.mp4)
- `$music_off` - Désactiver la musique
- `$help` - Afficher l'aide des commandes
- `$quit` - Quitter le jeu
- `Message sans $` - Envoyer un message chat

## 🎵 Musique

Pour activer la musique, placez le fichier `mus1k.mp4` dans le même dossier que les exécutables.

```bash
# Exemple pour télécharger une musique de test
wget -O mus1k.mp4 "https://example.com/votre-musique.mp4"
```

## 📊 Exemple de Session

```
Client> connect localhost 8080
Connexion au serveur localhost:8080...
Connecté avec succès !

=== BIENVENUE DANS LE JEU ===
Tapez $help pour voir les commandes disponibles.

> $play
=== PARTIE COMMENCÉE ===

=== PLATEAU DE JEU ===
    0  1  2  3  4  5  6  7 
0   ?  ?  ?  ?  ?  ?  ?  ? 
1   ?  .  .  .  ?  ?  ?  ? 
2   ?  .  @  .  ?  ?  ?  ? 
3   ?  .  .  .  ?  ?  ?  ? 
4   ?  ?  ?  ?  ?  ?  ?  ? 
5   ?  ?  ?  ?  ?  ?  ?  ? 
6   ?  ?  ?  ?  ?  ?  ?  ? 
7   ?  ?  ?  ?  ?  ?  ?  ? 

Tour: Joueur @ | Vos cases: 1

> $buy 2 3
Vous avez acheté la case (2, 3)!

> Salut tout le monde !
[@]: Salut tout le monde !
```

## 🛠️ Compilation Manuelle

Si vous préférez compiler sans Makefile :

```bash
# Serveur
gcc -Wall -Wextra -std=c99 -pthread -o game_server server.c

# Client  
gcc -Wall -Wextra -std=c99 -pthread -o game_client client.c
```

## 🐛 Dépannage

### Problèmes de Connexion
- Vérifiez que le serveur est lancé
- Vérifiez le port (pas déjà utilisé)
- Testez avec `localhost` d'abord

### Problèmes de Compilation
```bash
# Sur Ubuntu/Debian
sudo apt-get install gcc libc6-dev

# Sur CentOS/RHEL
sudo yum install gcc glibc-devel
```

### Musique ne Fonctionne Pas
```bash
# Installer mpv
sudo apt-get install mpv  # Ubuntu/Debian
sudo yum install mpv      # CentOS/RHEL
```

## 🎯 Stratégies de Jeu

1. **Expansion rapide** : Achetez des cases pour créer de grandes zones
2. **Blocage** : Empêchez les adversaires d'étendre leur territoire  
3. **Vision** : Utilisez votre vision limitée à votre avantage
4. **Timing** : Anticipez les mouvements des autres joueurs

## 🏆 Fonctionnalités

- ✅ **Serveur multijoueur** (jusqu'à 4 joueurs)
- ✅ **Interface terminal** intuitive
- ✅ **Chat en temps réel** entre joueurs
- ✅ **Plateau de jeu 8x8** avec brouillard de guerre
- ✅ **Tour par tour** avec validation des mouvements
- ✅ **Musique de fond** (optionnelle)
- ✅ **Commandes complètes** comme spécifié
- ✅ **Gestion des déconnexions**
- ✅ **Messages d'état** en temps réel

Amusez-vous bien ! 🎮