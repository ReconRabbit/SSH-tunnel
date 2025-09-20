# Tunnel SSH Access (Germany)

This guide explains how to SSH into the **Germany** container at  
`10.10.10.1` using a pre-generated SSH key so **no password** is required.

---

## 1. Generate the SSH Key

Run the key generation script **on the host** before starting the Docker containers:

```bash
cd ~/tunnel           # or the root of this project
./keygen.sh


## 2. Start docker containers

docker compose up -d --build

## 3. Cleaning up containers

Run the cleanup_tunnel.sh to remove the containers


 
MORE THINGS TO DO

# Using the above info, try and SSH to the Russian IP @ 200.53.76.61. Use the SSH key found on the Germany box. 

# Try to set up a port forward to directly access the webservice being hosted on the Russian box, on port 8080. 
