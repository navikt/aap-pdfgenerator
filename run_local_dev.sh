#!/bin/bash

CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PDFGENRS_VERSION=$(grep -m1 'ghcr.io/navikt/pdfgenrs' "$CURRENT_PATH/Dockerfile" | grep -o '[0-9][^"]*$')
PDFGENRS_IMAGE="ghcr.io/navikt/pdfgenrs:${PDFGENRS_VERSION}"

docker pull "$PDFGENRS_IMAGE"
docker run \
        -v $CURRENT_PATH/templates:/app/templates \
        -v $CURRENT_PATH/lib:/app/lib \
        -v $CURRENT_PATH/fonts:/app/fonts \
        -v $CURRENT_PATH/data:/app/data \
        -v $CURRENT_PATH/resources:/app/resources \
        -p 8089:8080 \
        -e DEV_MODE=true \
        -it \
        --rm \
        "$PDFGENRS_IMAGE"