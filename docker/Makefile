# Build the image.
build:
	docker build -t php-qa-image -f Dockerfile .

# Stop and remove all containers.
clean:
	docker stop php-qa-container
	docker rm php-qa-container

# Remove the image.
clean-image:
	docker rm php-qa-image

# Show all containers.
containers:
	docker ps -a

# Dig into the container.
exec:
	docker exec -it php-qa-container bash

# Show ip of default machine.
ip:
	docker-machine ip default

# List machines.
machines:
	docker-machine ls

# Run the container.
run:
	docker run -d -P --name php-qa-container \
							-v `pwd`:/srv/www/php-qa \
							-v `pwd`/docker/volumes/var/log/nginx:/var/log/nginx/ \
							php-qa-image