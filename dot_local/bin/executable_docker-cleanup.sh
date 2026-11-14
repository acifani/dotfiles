#!/bin/bash
set -euo pipefail

# stopped containers, unused networks, dangling images and build cache
docker system prune

# dangling volumes
docker volume prune
