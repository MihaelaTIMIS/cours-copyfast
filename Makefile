.DEFAULT_GOAL = help
.SILENT:

build-linux:  ## Build de la version linux
	env GOOS=linux GOARCH=amd64 go build -o build/linux/copyfast ./cmd/copyfast.go
	
build-darwin: ## Build de la version darwin
	env GOOS=darwin GOARCH=amd64 go build -o build/darwin/copyfast ./cmd/copyfast.go

build-windows: ## Build de la version windows
	env GOOS=windows GOARCH=amd64 go build -o build/windows/copyfast ./cmd/copyfast.go

build-all: build-linux build-darwin build-windows ## build de toutes les versions 

test: build-linux ## Test de la version linux sur container
	docker build --force-rm -t locals/copyfast .
	docker run locals/copyfast

run: ## run sans compilation du projet GO
	go run cmd/copyfast.go

help: #Pour gérer automatiquement l'aide ## Display all comands available
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
