# 🔐 Multi-Hop SSH Tunnel Lab

This training lab demonstrates how to create an **SSH tunnel** through a jump host
to securely access a remote web service that is otherwise unreachable.

---

## 🎯 Objective

- **Stage 1:** Connect to the **Germany jump host** (`10.10.10.1:2222`) using an SSH key.
- **Stage 2:** From Germany, connect to the **Russia host** (`200.53.76.61:22`).
- **Stage 3:** Access the **web service running on the Russian host (port 8080)**  
  directly from your local machine by setting up an SSH **port forward**.

---

## 🗂️ Lab Structure

| Component      | Role                           | Example Address      | Notes                                   |
|----------------|----------------------------------|----------------------|-----------------------------------------|
| **Germany**    | Jump/Bastion host               | `10.10.10.1:2222`         | First SSH hop. Holds `authorized_keys`. |
| **Russia**     | Target with web service         | `200.53.76.61:22`       | Hosts the site on **port 8080**.       |
| **Your Box**   | Local workstation (Kali, etc.)  | `localhost`          | Origin of all connections.             |

---

## ⚙️ Setup 

MAKE SURE YOU ARE IN THE "tunnel" DIRECTORY BEFORE CONTINUING
1. **Generate SSH Keys**
   ```bash
   ./keygen.sh
2. **Start Docker Containers**
   ```bash
   docker compose up -d --build
