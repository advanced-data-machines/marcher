# marcher - m(ulti) arch(itech) (dock)er

## Abstract
This is a simple project aimed to demonstrate building a fully containerized, statically compiled, Rust application targeting multiple chip architecture docker images.

## Motivations
Rust is awesome and it is fairly straightforward to cross compile binaries and executables for multiple architectures, however, a problem arises when building statically compiled Rust binaries that are to be deployed within docker conatainers targeting different CPU architectures.

Using straight docker-ce on my Ubuntu desktop to build an image to be deployed on a Raspberry Pi is not possible.   Traditionally this code would have to be transfered to the target platform (in my case Pi 3 B+ armv7l) then built (docker build) and resulting image pushed to DockerHub or your own image repo.

We can overcome this problem with Docker Buildx which makes it possible to build images for multiple architectures from most any CPU architecture. While a Raspberry Pi remains a marvel of modern engineering it is still painfully slow to build and compile complex applications on.  It is much prefereable to build these images on your multi core desktop machine that is tuned for this task then simply ```docker pull``` these images to your target device.


## Prerequisites
* Docker
* [Docker Buildx](https://docs.docker.com/buildx/working-with-buildx/)
* Dockerhub account
* Rust? - you actually don't need to have rust installed to run this example as the container will handle compilation etc. but it doesn't hurt.

## Build
Once you have enabled buildx study the Dockerfile included in this project and the buildx.sh script.

To build:
```
docker buildx build --platform=linux/arm/v7,linux/amd64 -t admachines/marcher:latest .  --push
```

## Resources
This article was most helpful in gaining a better understanding of croass compiling for different architectures.

https://piers.rocks/docker/containers/raspberry/pi/rust/cross/compile/compilation/2018/12/16/rust-compilation-for-raspberry-pi.html