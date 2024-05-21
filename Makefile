# Define image tags for each platform
LINUX_IMAGE_TAG=myapp-linux-amd64
ARM_IMAGE_TAG=myapp-arm64
MACOS_IMAGE_TAG=myapp-macos-arm64
WINDOWS_IMAGE_TAG=myapp-windows-amd64

.PHONY: all linux arm macos windows clean

all: linux arm macos windows

linux:
	GOOS=linux GOARCH=amd64 go build -o bin/linux/myapp ./...
	docker build --build-arg TARGET_PLATFORM=linux/amd64 --target linux -t $(LINUX_IMAGE_TAG) .

arm:
	GOOS=linux GOARCH=arm64 go build -o bin/arm/myapp ./...
	docker build --build-arg TARGET_PLATFORM=linux/arm64 --target linux_arm -t $(ARM_IMAGE_TAG) .

macos:
	GOOS=darwin GOARCH=arm64 go build -o bin/macos/myapp ./...
	docker build --build-arg TARGET_PLATFORM=darwin/arm64 --target linux_arm -t $(MACOS_IMAGE_TAG) .

windows:
	GOOS=windows GOARCH=amd64 go build -o bin/windows/myapp.exe ./...
	docker build --build-arg TARGET_PLATFORM=windows/amd64 --target windows -t $(WINDOWS_IMAGE_TAG) .

clean:
	rm -rf bin
	docker rmi $(LINUX_IMAGE_TAG) || true
	docker rmi $(ARM_IMAGE_TAG) || true
	docker rmi $(MACOS_IMAGE_TAG) || true
	docker rmi $(WINDOWS_IMAGE_TAG) || true
