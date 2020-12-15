#!/usr/bin/env bash

# Various tools written in go not managed by a package manager

go get -v golang.org/x/tools/gopls
go get -v github.com/ramya-rao-a/go-outline
go get -v github.com/uudashr/gopkgs/v2/cmd/gopkgs
go get -v github.com/sqs/goreturns
go get -v github.com/rogpeppe/godef
go get -v github.com/cweill/gotests/...
go get -v github.com/go-delve/delve/cmd/dlv

