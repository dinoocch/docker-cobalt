FROM liuchong/rustup:nightly-musl
WORKDIR /src/
RUN apt-get update && \
    apt-get install git -y && \
    git clone https://github.com/cobalt-org/cobalt.rs && \
    cd cobalt.rs && cargo build --target=x86_64-unknown-linux-musl --release

FROM alpine:latest
COPY --from=0 /src/cobalt.rs/target/x86_64-unknown-linux-musl/release/cobalt /bin/cobalt
RUN apk --no-cache add sassc
EXPOSE 3000
CMD ["/bin/cobalt/"]
