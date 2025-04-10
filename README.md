# [Revex] · Nginx Reverse Proxy for Local Projects 🧪

Revex is a minimal reverse proxy using Nginx to access all your local projects through `*.local` domains.

It also sets up a general self-signed HTTPS certificate you can **share across multiple projects and domains**, so everything runs smoothly — even with secure connections.

> Ideal for local development setups where you want simple, unified access to different containers or apps with HTTPS.

## Features ✅

- 🔁 Reverse proxy with wildcard domain support (e.g., `app.local`, `api.local`)
- 🔒 Self-signed HTTPS certificate shared across domains
- 🐳 Designed to work great with Docker-based environments
- 🛠️ Lightweight and easy to customize

## Use case

Tired of switching ports and ignoring browser warnings while working locally?  
Just run Revex and enjoy clean, secure URLs like:

