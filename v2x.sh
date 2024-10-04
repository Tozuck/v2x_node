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
IBcNMjQxMDA0MTYyNDM0WhgPMjEyNDA5MTAxNjI0MzRaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAnuKHoD1Zy/Hv
J/qpQNb9k0vzCccNEE6L8XuCkg8+Ti4PQvx1gRgySuja0SckQxBZ6kJypQYUg4oQ
2pkX9GFEiatT4Ttnm9TJUvme9rnxA+Bntmc0F47RtrtATYRkcieMdxeHXmZR3mEA
XqH9WVGobfmU6ozxz6GfwgSib6rYmFbW0yrRLBvfqG4ZhC0XNhQs4NUzG/HW+tnu
Vekfrl8+73FOsTsvhswIdfZjySLs7DDHstfuwzZncNxzxPifyj1Q0VDoGORzMae/
1bKAJAn+v+OU3d4VWq65zl3rLvn9xepauBQ0o05S3z4YWao7T3bfsnyij6/3ONki
xbph/u+1mL5JyTfExY65azsVgSljIREQH2CtYRbNLxGyn5muvZEwDbTgl4U/BsTT
fIP4vccxTSKVZMbn4zx96nsALlmwQ8nAfzGCYcbd/MOGVGpngB/jgQxcc3yRLK6m
xcn/rHHIAZamHtTSG3dBSYsV67ryHI0Pg5fBK92QXFxQ8sUyD6MJjQsXCJSnAoWM
NI0Iqy5y0GiZDK9UVQgQLwkkqWe0rN/q/DhthyWZY0TheIHDjaZ+73t/SwWylkOc
OWrm2j55+TRI2iKC485cfYGj2xIZ3i/z6KN5X+0X/qvyoh1B6ReIgIGmG4nM7UP2
963df2cEFRwJjGnzBhjXAuzBEDRwkTMCAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
EwXey/gffKmvLeF4qVgy3ru9pBXbunZia4RqbJQlTp/h6/dZxlNKhymb8kdi/LxJ
xtwKN8hVDuKC97q11Jbg6TjQJjEX6U/uzHSU1fkT4t2Mysm51C7KacD5XbIOCDer
MaO+lAFUFBqg7+aQMUcBTMdhHYMuKgpkE1MjwllRq18QUZQMWfhE6wUMAqVPezwq
+ZfHIdg0D3yDSar1RGMGl+tMI+JxLEGviwRlNsiinnyaPeVNRH/xNhtuvJvCqMmY
vfyRWIf+dMNPsqXfD3MLL57u2ciMHw5JST6hNeBOjB3uBNLlQHT6IkByfOu+ncsX
rJ1CCwtQwfaGFtfdXpNk8G5LsMkDSk+8pkl3XrUSZz8pN04r1oSfyaLfcOzYUe6m
Pq0lVyVA3vUjT0GBcuaZjYGwuSqzFdpaiaYvUKd987jjJ1OqyRyg3ToEk9a3E4cU
YYj3ZJd9wgZRm6UrgrfqH1oHzyxwz1KJ+HhRcavWvtD4qr1EqybmFqSXQVXoQwGY
03NCLbMPsPYepELcPlerINZ0oxTJ9yXENt2+hHpxuchG2kVPcVq93FnUoF/gqvbg
Wg6BEknV1PLUKTu6LqKOJ1DZj8QLyHHnV8/muFktKy3sH6rKWgW94B+thatQe+u+
AcPxZulZHW3LYDls3xESJ6HETy8l7KYVik7Y/xa7yf8=
-----END CERTIFICATE-----
EOL

# Pause for 3 seconds
sleep 3

# Run Docker Compose to start Marzban node
cd ~/Marzban-node
docker compose up -d
