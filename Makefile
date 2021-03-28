buildx:
	docker buildx create --use --name docker-graphicmagic
	docker buildx inspect --bootstrap
	docker buildx build --platform=linux/amd64,linux/arm64  -t atyasu/graphicmagic:latest --push .
