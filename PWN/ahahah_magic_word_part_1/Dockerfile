FROM debian:bookworm
RUN echo 'deb http://deb.debian.org/debian bookworm-backports main' > /etc/apt/sources.list.d/backports.list

ENV TIMEZONE=Europe/Paris

RUN apt-get update && apt-get install -y ncat gcc && rm -rf /var/lib/apt/lists/*

COPY ./ / 

WORKDIR /chall

RUN useradd --home=/hashcore -U hashcore

# Apply permissions on the ELF binary
RUN chmod 505 /chall/GRID_security_panel_cli
RUN chown hashcore:hashcore /chall/GRID_security_panel_cli

USER hashcore

CMD ["sh", "-c", "ncat -e /chall/GRID_security_panel_cli -l 4008 -k"]
