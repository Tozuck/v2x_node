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
IBcNMjQwNzA4MTIxNDQ2WhgPMjEyNDA2MTQxMjE0NDZaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEArajpmbqSHOq3
2t0ogsPgkmCWQfM8vCCoHidG566KyeDAlHJiwePB6xPyEday01OQggwFytZrmp2l
8A2M2x0LGRJZsen+kR6PYhCnIpMqBMy8TlqJPK0ZAgxmm7KQsxoZMihhjesrupxM
2uTycbLiVwmenARR6/N59Z/cAklfZFL1urdl1gxQsBWcRqxsgVDMDmoO2qMrB9jc
6Y6IpmZWzkf/LNXzl2HLJZmsEwDQrQEc8eeYnEiyP9R3/M2vnja34D4cPl7mTjZb
bT96cOKBYZB3d0lpykEhu9FFm5bc22HsGzB6BjpJxWePFuUa5SVuDcUMPJx8nm9R
0I5jB0RylQIWrbiH5lX00D7wt5sFspuPf0OHutzn+Vet+gDWr48VqgeuwFno7KgQ
dfKi4y/DkiDkCbV4bfdwfPvoXI8MTk0+yeeAw9bq5y0tLR10bBoNHEkxOTQmDRyP
2mA8kgSEHrT4YhgpUmVnKWo4e4FwXyJXboBmN06WdrlbbWliLpfxaSzSZTOAnBE/
EdrtvaRMhLZ1dYU2lXecEu7YWBlXxeP/8T+emr6FW0EPP7RxHUVk1eAe323hxvUM
2bwIG+UWmOp93/3LR1Fqo/BxbhhBqXvr2+BMiH3nOKlDQoyA6CqkuGlXdPnifJPh
GF3baKdo6bZZ+8kW1I/YKloeuh7EUw0CAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
WaAs2Z5DI5y4jBdEZQBX1+UuP6ac58KLzQlQ7I2umtU3BmGp4eOYsBRRuzWqGdmb
KZREdfdm8KsZfjAItkohNUokkwmRcIFw6d06yYS7CjJppcRpEhZLfNOU1Aj+e60h
pEKkjgNzTg87YsOGYxZBaifnz1FknS8qxUzrB/j349kfTfKNs1TAFugcwLRVW+Ud
85/0hZ+xq+1zE2wQ6/3ScTUa2TAVmf2uan/ib7lVDsSRVNWdq15EZVibVvcvnd+W
mYs0JkGLiolg9+RpEew6/OST78c98ZLwpRvEd3wvnNX9w7IRFVN/PWtkP0Ot3q0A
aB3B7PFu4E8lC8/SYs1z8ulu2BW7CpdmQdE/1DewBFn3DMsnJbQjlM/6EY2C4kwI
W7p27xO7pDFMmLUk3Nry1t4UHNo4fqiDvyKY8wwBGzZ1qxGI0OkryPWJN05X8XLK
yqmCnHT9lK4ULvnHkBNirg3vQPdFwpEYXEPnKAvNP/4kzprZfFq6JnumFVHD+9k7
/2smKN5OHf/uIwPfL6n8M8GgXJwjETrcvhwAthiYDfxl0Jp+Oc5J6AtcfyAgpNf3
HZJbJ+Zhe1UfwN2Jpo5dS0DIH/A7bsRKAICE6lcWI5gQOEkToWznm1cWXhg1uUNo
7+526MbHf5Av/cI+E1+Q2sKDkC+ntevdF1Pqri79dJQ=
-----END CERTIFICATE-----
EOL

# Pause for 3 seconds
sleep 3

# Run Docker Compose to start Marzban node
cd ~/Marzban-node
docker compose up -d
