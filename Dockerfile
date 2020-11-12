# 1: Build the exe
FROM rust:1.47 as builder
WORKDIR /usr/src

RUN apt-get update && \
    apt-get dist-upgrade -y     
#RUN apt-get install -y musl-tools 

# 1a: Prepare for static linking
RUN rustup target add x86_64-unknown-linux-musl
RUN rustup target add armv7-unknown-linux-musleabi
RUN arch=$(dpkg --print-architecture)
RUN echo $(arch)

WORKDIR /usr/src/myprogram
ENV RUSTFLAGS="-C target-feature=+crt-static"

# 1b: Build the exe using the actual source code
COPY Cargo.toml Cargo.lock ./
COPY src ./src

# When the container is built with armv7l statically compile with musl for arm
RUN if [ $(arch) = "armv7l" ]; then \
        cargo build --target armv7-unknown-linux-musleabi --release && \
        cp target/armv7-unknown-linux-musleabi/release/marcher  target/ ; \
    fi

# When the container is built with x86_64 statically compile with musl for arm
RUN if [ $(arch) = "amd64" ] || [ $(arch) = "x86_64" ]; then \
        cargo build --target x86_64-unknown-linux-musl --release  && \
        cp  target/x86_64-unknown-linux-musl/release/marcher  target/ ; \
    fi 

# 2: Copy the exe and extra file(s) to an empty Docker image
#    This is the image that will get pushed to your docker hub or other image repo
FROM alpine:3.12

WORKDIR /app
COPY --from=builder /usr/src/myprogram/target/marcher  .

#RUN ldd /app/marcher

USER 1000
ENTRYPOINT ["./marcher"]


# NOTE: see instruction on how to enable docker buildx 
# 
# To Build for arm/v7 and amd64:
# docker buildx build --platform=linux/arm/v7,linux/amd64 -t admachines/marcher:latest .  --push

