# Docker

## How to contribute

If you want to contribute to the project, first you create a folder with the language name inside the images folder. Then you create a `Dockerfile.base` and a `Dockerfile.standalone` inside this folder.

## Base images

The base images are used when the repository already contains a Dockerfile. The base images build the Dockerfile in the repository.

## Standalone images

The standalone images are used when the repository doesn't contain a Dockerfile.