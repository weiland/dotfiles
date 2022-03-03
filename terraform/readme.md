# Terraform

## Prerequisites

1. Install go
2. Install Terraform

## Install Providers

1. https://github.com/hetznercloud/terraform-provider-hcloud
2. https://github.com/andrexus/terraform-provider-inwx

Install a single provider:

1. Clone Provider to `$GOPATH/src/github.com/...`
2. Run `go install` in it's repo
3. Find the binaries in `$GOPATH/bin`
4. Make sure this file is stowed! (`stow -v --ignore=readme.md -t $HOME terraform`)