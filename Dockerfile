FROM golang:1.16.5

COPY /build/linux/copyfast /bin/copyfast

ENTRYPOINT ["/bin/copyfast"]
