#!/bin/bash
# GT_marz: A script to set up Marzban node

# Update and install necessary packages
apt-get update
apt-get upgrade -y
apt-get install curl socat git -y

# Pause for 2 seconds
sleep 2

# Disable UFW
ufw disable

# Install Docker
curl -fsSL https://get.docker.com | sh

# Pause for 2 seconds
sleep 2

# Clone the Marzban-node repository
git clone https://github.com/Gozargah/Marzban-node

# Create directory for Marzban-node
mkdir /var/lib/marzban-node

# Pause for 2 seconds
sleep 2

# Edit the docker-compose.yml file
cat <<EOL > ~/Marzban-node/docker-compose.yml
services:
  marzban-node:
    image: gozargah/marzban-node:latest
    restart: always
    network_mode: host

    environment:
      SSL_CLIENT_CERT_FILE: "/var/lib/marzban-node/ssl_client_cert.pem"

    volumes:
      - /var/lib/marzban-node:/var/lib/marzban-node
EOL

# Create SSL certificate file
cat <<EOL > /var/lib/marzban-node/ssl_client_cert.pem
-----BEGIN CERTIFICATE-----
MIIEnDCCAoQCAQAwDQYJKoZIhvcNAQENBQAwEzERMA8GA1UEAwwIR296YXJnYWgw
IBcNMjQwNzA4MTA1OTU2WhgPMjEyNDA2MTQxMDU5NTZaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA5azGsd+Az5Gw
0BH2IE2x3Wa2usCjSIk9pNX3IM301EbIaI+L+USWAJz6vUTG7RFA+NFdPFEKCH70
pTtCphdEvrsN6oF620d/IMMWt0dJfNaq3Qv6uJYnqDgV+pmUybxAknl40t+eQmg+
/24+ba9LMVGO0trxtY2N7C95koDsBWTur3SEnaArbH3batdmOSjKnoexTdV7qdFC
RQAxKqy5w672u0vBwuGGLA71TD7NXilvbZp4WPcU1+Ayo0RRfW9WKLCyd0QT1mtl
Dc4d0ZL+q6S+ALWryAwKWz2hRnG15KFXPGWhNJPBsJuemjadYlBs5SP+WPAUSsBT
IwkkXU9bWtEST//OXOW0jLsNmtbZlKZlHVmr4idvSXJgEfFVC4PnQn3wsNlPVMnI
kkzdmv0cLleYWwrYj0rBAjS5/VhhzE7S/rUQqK1nWgJ8aJ1SdHRQgkm7VfHUbk8F
V+LorD2AUfRrHJGGWPTMcTxVg1eaR1E04CzycXfBa94Q/PiK/WCBf7ZvAoTjiVBO
whqvhkfLBwWSz680VhrC09UtpNZVuMS86QsLclZiKLixVpQXL5llvNr97i+ZPhAN
Czo4hIZDRIs35e+P/EozVJzVeyYJC5ThVomBDEVxx8i4RwplTzyES3czZPKJrmim
8wIUqNZxlxH3YQVYI9f/Fl6OKVhdhqUCAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
aLxclGEwDFdrbZG7H+2fSy0gv0w6J+tKsl7Pk7IPKeVFod/ZygLaP3rXA4HrhorG
fVYTX1UN1BvbwoCbFz51TZw0IHsvDpzABc6lPOSkWZdpvHW4+8daJl/s6P+LSlwK
wC7gJYZNfCk4n6e5QTePoCdEAwkbiYXgO17nUbCX7h7QYSIOQWGI7bMwQy0hiS1L
QeKY8QkyjBRZLSVxKBLXk1ysogDB8FJ+S29dklk4tLRUZ6togmIFdGzcv69VPv9n
3Zyf6Ce5g9em+6lq2NgO/5od2AvlFhH0/tQ3rp78OjVaKpgiWQPI0iNeHXm7D97+
7/XmVAajtc4lv5aA1erEMRQK4/ynpigPr2J7ux2rsAAj/fMfvzp2lj0a2poXZ4k3
57cdYlXBgr2RF/MSG8FKHDSTxlqoFpDoXqfS7iv3x3uXE581zOUmW2SGGLHIVr8+
2KnWs88J+bz7cSXnxSG0/JHyp36tcjD9BLwRF/GEXp3ue873Y6asz7qAj54rA25q
udJtPZrOWwuUp7h5ufzIqvYTIK73gWLZszhryxFkcKxgnU2lf0EhXQ0PIAydNGgs
OH7Ikq797ikDLpih1lI1FW80VpMXDAnIXAb1mLf636MCFlcd24Y4iaPtoouWg1zb
uNP19HhtVUE6ckJr3BIv547Y/DSC5s574cZYwtXZy+Q=
-----END CERTIFICATE-----
EOL

# Pause for 3 seconds
sleep 3

# Run Docker Compose to start Marzban node
cd ~/Marzban-node
docker compose up -d
