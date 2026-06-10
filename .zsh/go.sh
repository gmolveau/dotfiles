export GOPATH=${HOME}/go
export GOBIN=${GOPATH}/bin
if [[ ! ":${PATH}:" == *":${GOBIN}:"* ]]; then
    export PATH="${PATH}:${GOBIN}"
fi