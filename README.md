# 🔐 Multi-Hop SSH Tunnel Lab

This training lab demonstrates how to create an **SSH tunnel** through a jump host
to securely access a remote web service that is otherwise unreachable.

---

## 🎯 Objective

- **Stage 1:** Connect to the **Germany jump host** (`root@10.10.10.1:2222`) using an SSH key.
- **Stage 2:** From Germany, connect to the **Russia host** (`root@200.53.76.61:22`).
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
| **Germany**    | Jump/Bastion host               | `root@10.10.10.1:2222`         | First SSH hop. Holds `authorized_keys`. |
| **Russia**     | Target with web service         | `root@200.53.76.61:22`       | Hosts the site on **port 8080**.       |
| **Your Box**   | Local workstation (Kali, etc.)  | `localhost`          | Origin of all connections.             |

---

## ⚙️ Setup 

MAKE SURE YOU ARE IN THE "tunnel" DIRECTORY BEFORE CONTINUING
1. **Generate SSH Keys**
   ```bash
   chmod +x ./keygen.sh
   chmod +x ./cleanup_tunnel.sh
   ./keygen.sh
2. **Start Docker Containers**
   ```bash
   docker compose up -d --build

