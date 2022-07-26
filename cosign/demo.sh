#! /usr/bin/env bash
#doitlive shell: /bin/zsh
#doitlive env:GITHUB_TOKEN=<your-token>
#doitlive env:COSIGN_EXPERIMENTAL=1
#doitlive env:GITHUB_ORG=<your-org>
#doitlive env:GITHUB_REPO=<your-repo>
cosign generate-key-pair "github://$GITHUB_ORG/$GITHUB_REPO"
cosign sign "$GITHUB_ORG/$GITHUB_REPO"
cosign verify "$GITHUB_ORG/$GITHUB_REPO" -o json | jq .
rekor-cli get --log-index 1819875 --format json | jq .
rekor-cli get --log-index 1819875 --format json | jq -r .Body.HashedRekordObj.signature.publicKey.content | base64 -d | openssl x509 -text -in /dev/stdin