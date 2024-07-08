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
IBcNMjQwNzA4MTAxNzAxWhgPMjEyNDA2MTQxMDE3MDFaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAsVpQK/2BNnWm
8Rg/amLwpi5BXNxuKGi8H3+65PkaczXAKvpkPVLPAc11owbHT73DawB1u3Df1+TT
yAFUTPJOVojnAvl085kWiNOdh9G7jqEQJEPfLjUZRr3sZ41QrSt84ADNtxsWGVrO
MLLx2ArGF4FTUy4KDTwRHn5zqMQaZvTgt0/RyYy21O0H0vaV41WnRZzXqwdd9meP
0TZPDp3xUIMDkIuigCYhN33ySWsFq1vXJVInTsj0ENWiC4uI2lE1vA5MJ3fuphXQ
gA8PE/v2SZSbzbUZiY5ZIPF4UNYolkXwAURuLt7hDrn2y1UXZCPrJjwZAQ2vmTiT
yOfH/TP4w2c43fAmIBMEpUhl/aCMoAt6mhvae32uzqf8Vj+d3oqFkw4qZAhV/jue
3s8i3vg1mvAF+hbN0pxk5gDVHRE6okScrqtYyYtrkT9P/K77r7cIfmVR0vhsUyNr
4AbRyKEHcl14T2pc1/czPOuCqgvT39cWIgkAQ0Ofz8akf8/YNh64qwNUheYlmIZ0
gWrJ8CyzIVPk7vBoD78zKSyvzIgaKa4DCHfgjBVvVkY0TW1pRDX+SY5fjQtkdCn+
P6yCHcjstjOtcxF8M+FI3ZIMdq1dfTAcPGDcl5I+WuIhO8EM4j7PukEM7hDwquVp
rHmE/s8NNiw90DsFsZ87Ox/8tmwYDcsCAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
U0PJ2pfJhW4z+H+kwDLmAGGP4eNlZIaqTiPGalZKid0diJQ9D0UFkdQoiNNoXQgZ
ZQ/CW/Eia6dXxNJe1qrYWPJtxYYnqhHBW8bo5XeOO7G4wvUuSMSKFqLFUbOrci8Y
3W5rVp3C1y4aU2zJTXH6mP/6U8FOWy50NoyzfMLR3aYWl5hw0+5/On/kwgK842l+
06A9Em6X2zOfSDSQJTpK+OXOo6LH6FGuMagAuyu7w4uoB4Y8ixiO5ElVqQ2t68WW
NknMhggghWxjTiZ+ipv6qm8j1rqPnoNzQfn9fZRxkjb9NNWYUpFxFCBZEiqnrYJv
gtB6Hr2gL83fyExDfOTxOu/XD1OCEi21946zLxUhlXhDC30idKG1YVmOsXQJv7S6
9+aiK6dGWphAN9Rtc59oCV2Qa0E7vi2oUVx3NAxoQmjApsn7m1T5ynauijGYH/dC
0zqjpTGxB4LPDZZFciuSKAR8Px5O7aIPMDFX0emNceGKSwJ9aEBf7m+gLAhYHwJr
rkhBuYSxDEIii+DbhkOxI6je/0G129AGcuKC7lb8LpaAGQuf07rkqtmVrSKjZC+J
rS3q2xler1dqQv/CLjsqFswOI8PLwUgKutNZsrJYfMLmZNTOd48o3G8XaGHud78U
5bFEX1tNn0HGVhmxCFrm3CW9ElHfO9MGA8zfAP+MYUg=
-----END CERTIFICATE-----
EOL

# Pause for 3 seconds
sleep 3

# Run Docker Compose to start Marzban node
cd ~/Marzban-node
docker compose up -d
