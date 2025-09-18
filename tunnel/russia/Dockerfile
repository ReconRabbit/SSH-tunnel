FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y openssh-server iproute2 iputils-ping && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd /root/.ssh

# Website
WORKDIR /var/www/html
COPY website/index.html /var/www/html/index.html

EXPOSE 22 8080

# Start SSHD and Python web server
CMD ["/bin/bash", "-c", "service ssh start && python3 -m http.server 8080 --directory /var/www/html"]

COPY authorized_keys /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys && \
    chown root:root /root/.ssh/authorized_keys

#EXPOSE 22
#CMD ["/usr/sbin/sshd", "-D", "-e"]
