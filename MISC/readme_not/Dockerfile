FROM ubuntu:22.04

# Install necessary packages
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y openssh-server build-essential sudo && \
    mkdir /var/run/sshd && \
    sed -i 's/#Port 22/Port 4003/' /etc/ssh/sshd_config

# Create user 'ctf' with password 'ctf'
RUN useradd -m -s /bin/bash ctf && echo 'ctf:ctf' | chpasswd

# Copy the binary to target location
COPY runme /opt/target/runme

# Set permissions: non-readable, executable, setuid
RUN chmod 111 /opt/target/runme && \
    chown root:root /opt/target/runme && \
    chmod +s /opt/target/runme

# SSH config
RUN mkdir -p /home/ctf/.ssh && chown -R ctf:ctf /home/ctf/.ssh

EXPOSE 4003
CMD ["/usr/sbin/sshd", "-D"]
