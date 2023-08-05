FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    mkdir /var/run/sshd && \
    sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set a default password if not provided (you can customize this)
ENV ROOT_PASSWORD=defaultpassword

# Set a default username if not provided
ENV USERNAME=default_user

# Set up user and grant sudo privileges
RUN useradd -m -s /bin/bash $USERNAME && \
    echo "$USERNAME:$ROOT_PASSWORD" | chpasswd && \
    usermod -aG sudo $USERNAME

EXPOSE 22

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
