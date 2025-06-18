FROM python:3.12-slim

# Création d'un user non root
RUN useradd -m ctfuser

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

# Permissions : seul ctfuser peut lire le flag
RUN chown ctfuser:ctfuser /app/flag.txt && chmod 400 /app/flag.txt
RUN chmod +x /usr/local/bin/python3
RUN chown -R ctfuser:ctfuser /app

USER ctfuser

EXPOSE 4015
CMD ["python3", "app.py"]
