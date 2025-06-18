FROM debian:bookworm
RUN echo 'deb http://deb.debian.org/debian bookworm-backports main' > /etc/apt/sources.list.d/backports.list

ENV TIMEZONE=Europe/Paris

RUN apt-get update && apt-get install -y ncat gcc python3 python3-pip && ln -s /usr/bin/python3 /bin/python && rm -rf /var/lib/apt/lists/*

RUN pip3 install --break-system-packages pycryptodome

COPY ./ /
WORKDIR /

RUN useradd --home=/hashcore -U hashcore

# On applique les droits sur le script chall.py
RUN chmod 505 /chall.py
RUN chown hashcore:hashcore /chall.py

USER hashcore

CMD ["sh", "-c", "ncat -e /chall.py -l 4000 -k"]
