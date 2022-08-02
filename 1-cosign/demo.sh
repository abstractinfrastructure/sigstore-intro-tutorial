#! /usr/bin/env bash
#doitlive shell: /bin/zsh
#doitlive env:COSIGN_EXPERIMENTAL=1
#doitlive env:GITHUB_ORG=jeefy
#doitlive env:GITHUB_REPO=sigstore-intro-tutorial

docker build -t "$GITHUB_ORG/$GITHUB_REPO" .

docker push "$GITHUB_ORG/$GITHUB_REPO"

cosign sign "$GITHUB_ORG/$GITHUB_REPO"

cosign verify "$GITHUB_ORG/$GITHUB_REPO" -o json | jq .

export uuid=$(cosign verify "$GITHUB_ORG/$GITHUB_REPO" -o json | jq '.[-1].optional.Bundle.Payload.logIndex')

# If you want to install the rekor-cli to interact with the public rekor instance directly...
rekor-cli get --format json --log-index $uuid | jq .

# If you have OpenSSL installed, you can use the following command to verify the signature:
rekor-cli get --format json --log-index $uuid | jq -r .Body.HashedRekordObj.signature.publicKey.content | base64 -d | openssl x509 -text -in /dev/stdin