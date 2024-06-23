# Use the official Golang image as the builder
FROM golang:1.20.3-alpine as builder

# Enable CGO to use C libraries (set to 0 to disable it)
# We set it to 0 to build a fully static binary for our final image
ENV CGO_ENABLED=0

# Set the working directory
WORKDIR /app

# Copy the Go Modules manifests (go.mod and go.sum files)
COPY go.mod go.sum ./

# Download the dependencies
RUN go mod download

# Copy the source code
COPY . .

# Build the Go application and output the binary to /app/ChatGPT-Proxy-V4
RUN go build -o /app/clashmege .

# Use a scratch image as the final distroless image
#FROM scratch
FROM grafana/alpine:3.15.4

# Set the working directory
WORKDIR /app

# Copy the built Go binary from the builder stage
#COPY ./ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /app/clashmege /app/clashmege

# Expose the port where the application is running
EXPOSE 6789

# Start the application
CMD [ "./clashmege" ]
