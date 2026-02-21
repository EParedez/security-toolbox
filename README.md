# Security Tools

Docker-based Kali Linux with a browser-accessible desktop (Selkies). Includes Nmap, Metasploit, Burp Suite, Wireshark, and common CLI tools.

---

## Prerequisites

- **Docker** and **Docker Compose**
- Recommended: 1 GB+ shared memory for the desktop (handled via `shm_size` in compose)

---

## Quick start

```bash
# Build and start
docker compose up -d --build

# Recreate after config changes
docker compose up -d --force-recreate
```

---

## Accessing the desktop

- **URL:** **https://localhost:7991/**
- **Protocol:** HTTPS only (accept the self-signed certificate in the browser if prompted)
- **HTTP Basic auth** (when `PASSWORD` is set):
  - **Username:** `abc`
  - **Password:** value of `PASSWORD` in `docker-compose.yml` (default: `hacktheplanet`)

**Important:** Change the default password in `docker-compose.yml` before exposing the container to any untrusted network.

---

## Important notes

### Security

- The container runs **privileged** and has **passwordless sudo** inside the web desktop. Treat it as a full Kali system.
- **Do not expose this container to the internet** without putting it behind a reverse proxy (e.g. SWAG) and proper authentication.
- Prefer storing secrets in a `.env` file (and add `.env` to `.gitignore`) instead of hardcoding them in `docker-compose.yml`.

### Persistence

- The `kali-data/` directory is mounted as the container’s home (`/config`). Projects, scans, and configs there persist across restarts.
- `kali-data/` is in `.gitignore` so local data and secrets are not committed.

### Network mode (Nmap / Wireshark)

- **macOS / Windows:** `network_mode: host` does **not** expose container ports to the host and is not suitable for reaching the web UI. The compose file uses **port mapping** so the desktop works at `https://localhost:7991`.
- **Linux:** For tools like Nmap and Wireshark to see the real host network, you can use host mode: in `docker-compose.yml`, uncomment `network_mode: host` and comment out the `ports:` section. Then open **https://localhost:7991/** (or **https://localhost:3001/**) on the Linux host.

### Ports

- The image uses **CUSTOM_HTTPS_PORT=7991** (Selkies), not `KASM_PORT`. The web UI listens on **7991** (HTTPS).

---

## Included tools

- **Nmap** — network scanning  
- **Metasploit Framework**  
- **Burp Suite**  
- **Wireshark** (configured for non-root capture)  
- **mousepad**, **curl**, **ping**  
- Full Kali desktop (browser-based)

---

## Useful commands

```bash
# Logs
docker logs -f kali-lab

# Shell inside container
docker exec -it kali-lab /bin/bash

# Stop
docker compose down
```

---

## Optional: no authentication

To disable HTTP Basic auth, remove or comment out the `PASSWORD` line in `docker-compose.yml` and recreate the container.
