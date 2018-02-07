
#!/usr/bin/env bash
docker run --rm -v $(pwd):/src -w /src golang:1.9.3-alpine /bin/sh -c "go build -o defaultstaticwebapp"