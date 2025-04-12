#!/bin/bash

set -e

CERT_DIR="/etc/nginx/certs"
SITES_DIR="/etc/nginx/sites-enabled"

echo "🔍 Searching for *.local domains in: $SITES_DIR"

# Buscar todos los dominios .local en los archivos de configuración
DOMAINS=$(grep -rhoP 'server_name\s+\K\S+\.local' "$SITES_DIR" | sort -u)

if [ -z "$DOMAINS" ]; then
    echo "⚠️  No *.local domains found in configuration files. Skipping certificate generation."
else
    for DOMAIN in $DOMAINS; do
        DOMAIN_CERT_DIR="$CERT_DIR/$DOMAIN"
        CRT="$DOMAIN_CERT_DIR/selfsigned.crt"
        KEY="$DOMAIN_CERT_DIR/selfsigned.key"

        if [ -f "$CRT" ] && [ -f "$KEY" ]; then
            echo "✅ Certificate already exists for $DOMAIN"
        else
            echo "🔐 Generating certificate for $DOMAIN..."
            mkdir -p "$DOMAIN_CERT_DIR"
            openssl req -x509 -nodes -days 365 \
                -newkey rsa:2048 \
                -keyout "$KEY" \
                -out "$CRT" \
                -subj "/C=XX/ST=Local/L=Local/O=Dev/OU=Dev/CN=$DOMAIN"
        fi
    done
fi

echo "🧪 Testing Nginx configuration..."
nginx -t

echo "🚀 Starting Nginx..."
nginx -g 'daemon off;'
