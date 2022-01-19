docker system prune

# remove stopped containers
docker rm $(docker ps -q -f 'status=exited')

# remove orphan images
docker rmi $(docker images -q -f "dangling=true")

# remove orphan volumes
docker volume rm $(docker volume ls -qf dangling=true)

