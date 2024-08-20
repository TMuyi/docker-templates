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
