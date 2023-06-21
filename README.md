# Docker Compose Templates

This repository contains the base docker compose scripts for my self-hosted projects. I deploy and manage various applications and services on my own devices using Docker/Podman.

## Table of Contents

- [Docker Compose Templates](#docker-compose-templates)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Usage](#usage)
  - [List](#list)
    - [Dashboards](#dashboards)
    - [Password Management](#password-management)
    - [Proxies](#proxies)
    - [Network](#network)
    - [Media](#media)
    - [Filesharing \& Backups](#filesharing--backups)
    - [Development](#development)
    - [Container Management](#container-management)
    - [Planning \& Budgeting](#planning--budgeting)
    - [Web App testing](#web-app-testing)
  - [TODO](#todo)

## Prerequisites

Each container has specific requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Podman](https://podman-desktop.io/)
- [Podman Compose](https://github.com/containers/podman-compose#installation)

## Usage

To use a specific Compose script from this repository, follow these steps:

1. Clone this repository to your local machine:

   ```
   git clone https://github.com/your-username/self-hosted-docker-compose.git
   ```

2. Navigate to the project directory of your choice:

   ```
   cd project-directory
   ```

3. Modify the `compose.yml` file if necessary, adjusting any environment variables, ports, volumes, or other configuration options to fit your needs.

4. Start the application stack using Docker Compose:

   ```
   docker-compose up -d
   ```

   Using Podman;

   ```
   podman-compose up -d
   ```

   This command will start the containers defined in the `compose.yml` file in detached mode, allowing the services to run in the background.

5. Access the application by visiting the appropriate URL or IP address in your web browser, depending on the application you deployed.

6. To stop and remove the containers, run the following command within the project directory:

   ```
   docker-compose down
   ```

   Using Podman;

   ```
   podman-compose up -d
   ```

   This will stop the containers and remove any associated volumes, networks, and other resources created by Docker Compose.

<!-- ## License -->

## List

### Dashboards

- Homer
- Heimdall

### Password Management

- Vaultwarden

### Proxies

- Nginx Proxy Manager
- Caddy

### Network

- IPerf3
- Unifi Controller
- Pihole

### Media

- Jellyfin
- Stash
- QBittorrent
- JDownloader

### Filesharing & Backups

- Nextcloud
- Duplicati

### Development

- VSCode

### Container Management

- Portainer
- Watchtower
- Uptimekuma
- Changedetection

### Planning & Budgeting

- Grocy
- BudgetZero

### Web App testing

- Webgoat
- OWASP Juice Shop

## TODO

- add podman setup scripts
- add links to container lists
- add container descriptions
- add container-specific requirements
- add vaultwarden config
- add homepage config
- add caddy config
- add paaster config
- add turtl config (& postgres instance)
- add huginn config
- add actual config
- add changedetection.io config
- add Uptime-kuma config
