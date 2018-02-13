# Create a minimal container to run a Golang static binary
FROM golang:1.9 as builder
ADD . /go/src
WORKDIR /go/src
RUN go get -d
RUN CGO_ENABLED=0 go build -a --installsuffix cgo --ldflags="-s" -o whoamI

FROM scratch
COPY --from=builder /go/src/whoamI /
ENTRYPOINT ["/whoamI"]
EXPOSE 80
