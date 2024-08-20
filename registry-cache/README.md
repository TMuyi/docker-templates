# Setting Up a Docker Pull-Through Cache

I’m documenting the steps I took to set up a pull-through cache for Docker images and automate the process of tagging and pushing existing images to a local Docker registry. This allows me to avoid re-downloading images from the internet, which can generate quite a bit of traffic, especially since I frequently hop between different Linux distributions and test new VMs.

## Prerequisites

- Two machines: "Machine A", with existing Docker images, and "Machine B", the target machine.
- Docker installed on both machines.

## Disclaimer

These steps are meant for testing in a local environment. It is insecure and should be treated as such.

## Overview

The goal is to set up Machine A as a Docker registry that serves as a "pull-through cache". Machine B will pull images through Machine A, caching them locally if they are not already cached.

### Steps to Set Up Machine A as a Pull-Through Cache

1. **Install Docker Registry on Machine A:**

   First, you need to run a Docker registry on Machine A:

   ```bash
   docker run -d -p 5000:5000 --name registry registry:2
   ```

2. **Configure the Registry as a Proxy Cache:**

   Create a custom configuration file to set the registry as a pull-through cache:

   1. **Create a Configuration Directory:**

      ```bash
      mkdir -p ~/registry-config
      ```

   2. **Create the Configuration File:**

      Inside the `registry-config` directory, create a file named `config.yml`:

      ```bash
      nano ~/registry-config/config.yml
      ```

      Add the following content:

      ```yaml
      version: 0.1
      proxy:
        remoteurl: https://registry-1.docker.io
      ```

      This configuration tells the registry to act as a proxy cache for Docker Hub.

   3. **Run the Docker Registry with the Custom Configuration:**

      Now, run the registry with the custom configuration:

      ```bash
      docker run -d -p 5000:5000 --name registry \
        -v ~/registry-config/config.yml:/etc/docker/registry/config.yml \
        registry:2
      ```

3. **Configure Machine B to Use the Cache on Machine A:**

   On Machine B, you need to configure Docker to use the registry on Machine A as a mirror:

   1. Edit Docker’s daemon configuration file (`/etc/docker/daemon.json`):

      ```json
      {
        "registry-mirrors": ["http://<MachineA-IP>:5000"]
      }
      ```

      Replace `<MachineA-IP>` with the IP address of Machine A.

   2. Restart Docker to apply the changes:

      ```bash
      sudo systemctl restart docker
      ```

   > **Note:** If you run into any errors at this stage, running `sudo dockerd --debug` can provide useful information for troubleshooting.

### Making Existing Images Available in the Cache

The images downloaded on Machine A prior to setting up the cache will not automatically be available in the registry cache under the original names. However, once the cache is set up, you can directly pull images using their original names from Machine B. The cache will check if the image is available locally and pulling it from Docker Hub only if necessary.

E.g:

```bash
docker pull lscr.io/linuxserver/jellyfin:latest
```

In this scenario:

- If `lscr.io/linuxserver/jellyfin:latest` is already cached on Machine A, it will be served from there.
- If it’s not cached, Machine A will fetch it from Docker Hub, cache it, and then serve it to Machine B.

There’s no need to tag or manually push images if you continue to use the original names.

### Re-Pulling Cached Images with Original Names on Machine A

If you want to make sure certain images are cached under their original names without re-downloading them on Machine B, you can re-pull the images on Machine A:

```bash
docker pull lscr.io/linuxserver/jellyfin:latest
```

This ensures that Machine A has the image cached under its original name.

### Optional: Manually Push Images to the Registry

If you want more control over which images are cached or avoid re-pulling, you can manually push images from Machine A to the local registry:

```bash
docker tag <existing-image> localhost:5000/<image-name>
docker push localhost:5000/<image-name>
```

### Tagging and Pushing of Existing Images

If you have a lot of existing images that need to be tagged and pushed, you can just do this with a basic script

### Bash Script to Tag and Push Images

The script reads image names from a file, tags them for the local registry, and then pushes them:

```bash
#!/bin/bash

# Check if the file containing image names is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <image-names-file>"
    exit 1
fi

# File containing the list of image names
IMAGE_FILE=$1

# Local registry address
LOCAL_REGISTRY="localhost:5000"

# Loop through each image name in the file
while IFS= read -r IMAGE_NAME; do
    if [[ -n "$IMAGE_NAME" ]]; then
        # Tag the image for the local registry
        docker tag "$IMAGE_NAME" "$LOCAL_REGISTRY/$IMAGE_NAME"

        # Push the tagged image to the local registry
        docker push "$LOCAL_REGISTRY/$IMAGE_NAME"

        echo "Tagged and pushed: $IMAGE_NAME"
    fi
done < "$IMAGE_FILE"

echo "All images processed."
```

### How to Use the Script

1. Save the script as \*.sh.
2. Make the script executable:

   ```bash
   chmod +x <script-name>.sh
   ```

3. Create a file (e.g., `images.txt`) with the names of the images you want to tag and push:

   ```text
   lscr.io/linuxserver/jellyfin:latest
   ubuntu/squid
   ```

4. Run the script and pass the file containing the image names:

   ```bash
   ./<script-name>.sh images.txt
   ```

### To-Do

- [x] Add script for tagging existing images
- [ ] Create a Docker Compose configuration for the registry container
- [ ] Add a registry ui for managing the registry
- [ ] Add cache expiry duration (preferably set to `0` to keep images indefinitely).
- [ ] Add security (consider implementing TLS and authentication for a production setup).

---

For further reading and references, check out the [official Docker distribution documentation](https://distribution.github.io/distribution/).
