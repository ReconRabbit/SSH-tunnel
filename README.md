# 🔐 Multi-Hop SSH Tunnel Lab

This training lab demonstrates how to create an **SSH tunnel** through a jump host
to securely access a remote web service that is otherwise unreachable.

---

## 🎯 Objective

- **Stage 1:** Connect to the **Germany jump host** (`root/germany@10.10.10.10:22`) For username 'root' - use the SSH key. For username 'germany' - use the password of 'blitz'
- **Stage 2:** From Germany, connect to the **Russia host** (`root/russia@200.53.76.61:22`) For username 'root' - use the SSH key. For username 'russia' - use the password of 'rasputin'
- **Stage 3:** Access the **web service running on the Russian host (port 8080)**  
  directly from your local machine by setting up an SSH **port forward**.

---

## 1️⃣ Host System Requirements
- **Operating System**:  
  - Linux (Kali, Ubuntu, Debian, Fedora, Arch)  
  - macOS  
  - Windows (with WSL2 or Docker Desktop)
- **Privileges**:  
  - User must be able to run `docker` and `docker compose` commands  
  - Ability to create and remove containers/networks.

---

## 2️⃣ Installed Software Requirements
| Tool | Version | Purpose |
|------|--------|---------|
| **Docker Engine** | ≥ 20.x | Runs the Germany, Russia, and Router containers |
| **Docker Compose** | ≥ 2.x | Orchestrates the multi-container environment |
| **OpenSSH Client** | Standard | Provides the `ssh` binary for key generation and tunneling |
| **curl** (optional) | Latest | Quick HTTP testing of the forwarded web service |

---

## 🗂️ Lab Structure

| Component      | Role                           | Example Address      | Notes                                   |
|----------------|----------------------------------|----------------------|-----------------------------------------|
| **Germany**    | Jump/Bastion host               | `root@10.10.10.10:22`         | First SSH hop. Holds `authorized_keys`. |
| **Russia**     | Target with web service         | `root@200.53.76.61:22`       | Hosts the site on **port 8080**.       |
| **Your Box**   | Local workstation (Kali, etc.)  | `localhost`          | Origin of all connections.             |

---

## Usernames and passwords
## Germany Host

root : utilize SSH key

germany : blitz

## Russia Host

root : utilize SSH key

russia : rasputin

## ⚙️ Setup 

MAKE SURE YOU ARE IN THE "tunnel" DIRECTORY BEFORE CONTINUING
1. **Permit Execution of Scripts**
   ```bash
   chmod +x *.sh
2. **Start Docker Containers and generate keys**
   ```bash
   docker compose up -d --build
   ./keygen.sh
3. **Remove Ability To Talk Directly To Russian Host**
   ```bash
   ./ip-route-del.sh
4. **Clean up docker, tunnel, ip tables**
   ```bash
   ./cleanup_tunnel.sh

