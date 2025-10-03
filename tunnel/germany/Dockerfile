FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y openssh-server iproute2 iputils-ping && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd /root/.ssh

#COPY authorized_keys /root/.ssh/authorized_keys
#RUN chmod 600 /root/.ssh/authorized_keys && \
#    chown root:root /root/.ssh/authorized_keys

# Add Russia private key so Germany can SSH to Russia
COPY /keys/id_rsa_russia /root/.ssh/id_rsa_russia
RUN chmod 600 /root/.ssh/id_rsa_russia && chown root:root /root/.ssh/id_rsa_russia

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]
