# Docker Compose Templates

This repository contains the base docker compose scripts for my self-hosted projects. I deploy and manage various applications and services on my own devices using Docker/Podman.

## Table of Contents

- [Docker Compose Templates](#docker-compose-templates)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Usage](#usage)
  - [TODO:](#todo)

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

## TODO:

- add podman setup scripts
- add container-specific requirements
- add vaultwarden compose file
- add caddy compose file
- add links to container lists
