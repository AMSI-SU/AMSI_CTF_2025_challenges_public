CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -pthread -m32
LDFLAGS = -pthread

# Noms des exécutables
SERVER = game_server
CLIENT = game_client

# Fichiers sources
SERVER_SRC = server.c
CLIENT_SRC = client.c

# Règle par défaut
all: $(SERVER) $(CLIENT)

# Compilation du serveur
$(SERVER): $(SERVER_SRC)
	$(CC) $(CFLAGS) -o $(SERVER) $(SERVER_SRC) $(LDFLAGS)

# Compilation du client
$(CLIENT): $(CLIENT_SRC)
	$(CC) $(CFLAGS) -o $(CLIENT) $(CLIENT_SRC) $(LDFLAGS)

# Nettoyage
clean:
	rm -f $(SERVER) $(CLIENT)

# Installation des dépendances (optionnel)
install-deps:
	@echo "Vérification des dépendances..."
	@which gcc > /dev/null || (echo "ERREUR: gcc n'est pas installé" && exit 1)
	@which mpv > /dev/null || echo "ATTENTION: mpv n'est pas installé (nécessaire pour la musique)"
	@echo "Dépendances OK!"

# Test rapide
test: all
	@echo "Lancement du serveur sur le port 8080..."
	@echo "Utilisez './$(CLIENT)' dans un autre terminal pour vous connecter"
	@echo "Commande de connexion: connect localhost 8080"
	./$(SERVER) 8080

# Aide
help:
	@echo "Makefile pour le jeu multijoueur"
	@echo ""
	@echo "Commandes disponibles:"
	@echo "  make all         - Compile le serveur et le client"
	@echo "  make server      - Compile seulement le serveur"
	@echo "  make client      - Compile seulement le client"
	@echo "  make clean       - Supprime les exécutables"
	@echo "  make install-deps- Vérifie les dépendances"
	@echo "  make test        - Lance le serveur pour test"
	@echo "  make help        - Affiche cette aide"
	@echo ""
	@echo "Utilisation:"
	@echo "  1. make all"
	@echo "  2. ./$(SERVER) <port>    (ex: ./$(SERVER) 8080)"
	@echo "  3. ./$(CLIENT)           (puis: connect localhost 8080)"

.PHONY: all clean install-deps test help