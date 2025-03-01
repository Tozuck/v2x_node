#!/bin/bash

set -e  # Exit on any error

# Function to log and print messages
echo_info() {
  echo -e "\033[1;32m[INFO]\033[0m $1"
}
echo_error() {
  echo -e "\033[1;31m[ERROR]\033[0m $1"
  exit 1
}

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo_error "This script must be run as root. Use sudo."
fi

# Update system packages
echo_info "Updating package lists..."
apt-get update

# Install required packages
echo_info "Installing required packages..."
apt-get install -y curl socat git ufw || echo_error "Failed to install packages."
apt install iftop -y
apt install nload
# Configure UFW (firewall)
echo_info "Configuring UFW..."
ufw allow 22  # SSH
ufw allow 80  # HTTP
ufw allow 443 # HTTPS
ufw allow 2053
ufw allow 2087
ufw allow 62050
ufw allow 62051

# Install Docker
echo_info "Installing Docker..."
if ! command -v docker &> /dev/null; then
  curl -fsSL https://get.docker.com | sh || echo_error "Docker installation failed."
else
  echo_info "Docker is already installed."
fi

# Clone Marzban Node repository
echo_info "Cloning Marzban Node repository..."
if [ ! -d "~/Marzban-node" ]; then
  git clone https://github.com/Gozargah/Marzban-node ~/Marzban-node || echo_error "Failed to clone Marzban Node repository."
else
  echo_info "Marzban Node repository already exists."
fi

# Create necessary directories
echo_info "Creating necessary directories..."
mkdir -p /var/lib/marzban-node

# Generate Docker Compose configuration
echo_info "Creating Docker Compose configuration..."
cat <<EOL > ~/Marzban-node/docker-compose.yml
services:
  marzban-node:
    image: gozargah/marzban-node:latest
    restart: always
    network_mode: host
    environment:
      SSL_CERT_FILE: "/var/lib/marzban-node/ssl_cert.pem"
      SSL_KEY_FILE: "/var/lib/marzban-node/ssl_key.pem"
      SSL_CLIENT_CERT_FILE: "/var/lib/marzban-node/ssl_client_cert.pem"
      SERVICE_PROTOCOL: "rest"
    volumes:
      - /var/lib/marzban-node:/var/lib/marzban-node
EOL

# Generate placeholder SSL certificate
echo_info "Creating placeholder SSL certificate..."
cat <<EOL > /var/lib/marzban-node/ssl_client_cert.pem
-----BEGIN CERTIFICATE-----
MIIEnDCCAoQCAQAwDQYJKoZIhvcNAQENBQAwEzERMA8GA1UEAwwIR296YXJnYWgw
IBcNMjQxMjA5MTM1OTM1WhgPMjEyNDExMTUxMzU5MzVaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAw/RlIoR4B/5c
7dR1leRbFWVeYPm3ZhhyJF5yQ/4yw57SK+7TUHTmp/1NUfRPiN6hRssHwVUCkxoV
W9/mj2SzhP5mTErBmkisK8SAyQyD7fX4RsbAykgKncsVjjAQ0ABFAVOy25XR2Fkz
BfrkBBKbdLPIvqSP7GhlFcBm+M27AycRMvQWi885plsLZTfR403XZeKY+RGptQ8n
Nyj8fUGERalRnRaIQF8AH1QFSEVWouzEXREojzpULATw5l2lYCe2iJk3Kq0G2cCJ
P+qijGJEPNFBLKT23IZAnGdf9TX+2xPoWxwmQLXVt0jKnPSujFWflZ/7nQeng3/W
SrwHqsmft8ryd3soCDiLtIje8GtalSH8fK+muDilF7iZyouG0VwPkX+dvFrqwmsh
IdPvjd79q/PaAIL7kbyHj/z56GhNYfjO92Ug70jtvaYRNfBYvmHhmg2ZwofuXBee
nCytFMYOpNbHhFz9AshPMR2KhbvbS7akwOnObd3FacxILWtKDhmzeDv9x+Pay5Jq
lInGA3QYfPvTqe+h0+saRZIBVCQK7+ABv380WqF89rN9G153gvsyJkc0HGr83eps
rMbEwg62bLw+7lWym+mtnch+NeoMfMfLAeWxGUr6beXHPj6+gzbURqyhcNxVpVJ/
ZFcH/7zIvLJ5wZXVJpMpoCiSHxIsfHUCAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
nAf41y1PpQ/sz0KUEWkwAno0zn6zxQcXCbvdZ7ZWG2UdiqiwH5cCcyk1E2HDKGvu
0Oa9ZA6HmgUlkZVGo3+4xcjaP/6soh9wMcWR3I61mtGdM6HyOoVR03HifEyMKvMQ
Wxpu4DKeooknsKEPse4y4oCGzoM5iepDj3s80WVJ2RhKCcVVeScWgL4GumqSZHYG
4DQtNZwKvzlOZAbpuaNF6EYEOGTGJGuvEzsLG4v6x7BJ9I2yPbI7/X+FZfmbv7h6
2qVDH6h9MY662zJQ3d8Gaxx0Pvcqcp+ulI1YlrzBH2TDJtGo7kx066xhewvDqDeD
fG+wNkAp6J5Fra77wnXFVU3tTv5jT6WJAoFmPWUBfo9oYB65nVMm8gJssCfKegrw
o66cTkeveuOYddauhZJled0YQhXsj+wakjb7z3YRcOamnklLlWh5VCliijoiULk5
WvCfSo3qa5I9N1nn98r40ZUr1QtNqKtqJ/Jx1lQ5gWo5nQHPiVMDvVZopCbEA9cQ
3ig/p+TNWIi5RV2Hy67/eGnpGQwsKQ03Lc6ZIFUzrx+HBXgVWNIcrS3ZJSkChuRT
5Ck5icMUxr+CS3CDaFVRwmrqdw84ZW9wTB4wWfGLh2Gv8MH/N3Yle0fK3ahpuQKh
0KUO2+ZwpQ4Kx40M0/1LYKdjvjcJJ3izGEUJ19GHcu8=
-----END CERTIFICATE-----
EOL

# Start the Marzban Node service
echo_info "Starting Marzban Node service..."
cd ~/Marzban-node
docker compose up -d || echo_error "Failed to start Marzban Node service."

# Enable and reload UFW
echo_info "Finalizing UFW setup..."


# Clear shell history for security
echo_info "Clearing shell history..."
history -c

# Sleep for 3 seconds before closing the connection
echo_info "Setup complete. Marzban Node is now running. Closing connection in 3 seconds..."
touch /tmp/gt_marz_installed_complete
