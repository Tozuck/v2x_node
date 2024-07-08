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
IBcNMjQwNzA4MTEyNDA3WhgPMjEyNDA2MTQxMTI0MDdaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA3zh5YFaT4lN+
bWk06XvftK0QT5mt3F0rMBIE6w8dplo/7UZUmxrlu6tsssCqM19W0qdGln/mufr0
1qqw2TFjVltGNdivXVtswxGhUyYFGKd41yqkp9qVdcNnxbGLQKE5J8hCH3763PIQ
NHLHtMlv1dXhCC9ik2LuueSXlgF6wXEBSgT/2Oluc15syiEBRJ4WNXt//xtUxAlP
bA2XeFDOGxf8PoQdK1d5rl0r4h9VDjRT+YbAcb4/ZciLsE/Wy2UR4O/2XXMfTdrv
FjX+9xWjswgT3ejTJtJGUWRg87Vbv06gbD96azW/NtEjrdfhInl6ORdRWg9aiaos
DUDUWeTtsqjFkFu3z0LP/Ddkgt4pO8VlwxIYjnff3EXcTueZJMuiVetvFkr8cumx
gLk4MBHk8XHpReCTcw/MtXZYKaeMFRfFmbymMHhsvP44nnO+uixadMgGMQdbxZOR
4dB7q20aqju/QF2N0sn4GeBit7A7Gq45tU1shReS8gJ/Y7wdCIjVNJxM7pAGn6ET
oH4YTNCvKDM/g3aSMohbEJrZf+0UCZ0IMLMmBX3TNCaulqKBGVMtHmnLL3k0utup
92DbMWAi4pnzlSP4x+wHVBf8+kk6RQ9kaL0K3iy6/pnTf49CxhlXmYImX6Nu+N59
+zhgvD1Gu/SIFljw+/IhXzDp/W4Cst0CAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
kfE/yPGuP2bIrGIGHEyDXW/2l2+ZID0cidAZ1fD3E03bJEk9fsZXK6SHG8EQWln9
NU7oObTvkKGXeCNeZuEayGaaz9/3XHJxKyJ8qBs/YVOZJQdpRhEXlh3MrmIPwx+O
V2KG0LjFs5Kj3Bg1EVcDIZsSdbHWngX4LNNc/J7ViC913ahsxrlBX+JZZ6r6YfQ7
jrrQP9aQsUXE8uQoyT3slp9Stqulsr6p6A/HUYgJ9PgzD41lznqxGXpjoOoEKiQT
mzTmAk1JoSbAsjzBwo2ySR5x9KrcJcpSye8UjW73MK9uewwlcvU6mGXsO0eJVPNW
g/pw3NI2/M7x9kEX50UNTilxEES1UMgRK3ArSprUJ0L5fqCtKxkzRYhrOrWJabTj
i9lvHSPNDK1iGOquWV8NSb1zz02UODLsBDb0JQfrVa46TiVyqohMBUAAIt14e2ry
K4ta1n6MMv8BmimCcHrSc5pFTWiH7Rquib+FhTDU/KGnQi1X3kVUO+re1XmFxlbC
U24QdzhC6E5h6RLVpnQzXUBPKchI88dCY3no7jsVGv9QymEbW4DwHofkpkkjdNux
Wjn2HjQCkegYN7L/23FsyJFo4FElgfQKcJ9lUYmQJ4TZfT1ptNITehHTmEL2KFaK
PvZEQAlVRGhX5ypt9SgMNb2IX8cZHQFBUvED5QBTsPM=
-----END CERTIFICATE-----
EOL

# Pause for 3 seconds
sleep 3

# Run Docker Compose to start Marzban node
cd ~/Marzban-node
docker compose up -d
