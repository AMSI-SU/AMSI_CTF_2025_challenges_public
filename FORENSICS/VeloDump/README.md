# FORENSICS : 02 -  Velo'Dump

- **Auteur :** _mahmoudlb
- **Catégorie :** FORENSICS
- **Diffculté :** Facile
- **Points :** -
- **Points dynamiques :** oui
- **Indice 1 :**
```
Pas d'indice 1.
```

- **Description :**
```
Une borne d’arcade collector aux couleurs de l’OM, soigneusement installée sous les tribunes du Vélodrome, a été utilisée à l’insu du club pendant un match à guichets fermés.
Profitant d'une session restée ouverte, un supporter du QSG a lancé un malware qui a établi une connexion vers un serveur distant, trahissant l’esprit du Virage Sud.
Explore le dump mémoire pour retrouver la trace du binaire, le nom de la machine, l’utilisateur qui a laissé sa session ouverte, ainsi que l’adresse IP et le port de cette attaque contre la fierté olympienne.

Lien de l'archive: https://www.swisstransfer.com/d/a0ae22c2-aecd-4e8d-94a9-4db9eaa6c94d
Format du Flag AMSI{HOSTNAME:USERNAME:PROCESS_NAME:REMOTE_IP:REMOTE_PORT}
```

- **Remarques :**
```
```

- **Dialogues :**
```
Pas de dialogue.
```

Flag : AMSI{vbox:plongoria:office:192.168.0.31:443}






