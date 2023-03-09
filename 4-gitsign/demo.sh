#! /usr/bin/env bash
#doitlive shell: /bin/zsh

# go install github.com/sigstore/gitsign@latest
# OR
# brew tap sigstore/tap
# brew install gitsign

# Let's set the git config for this repo to use gitsign
git config --local commit.gpgsign true  # Sign all commits
git config --local gpg.x509.program gitsign  # Use Gitsign for signing
git config --local gpg.format x509  # Gitsign expects x509 args

# Now let's create a new branch for funsies
git checkout -b demo-test-branch

# And create an empty commit which will be signed
# This should take you through the sigstore process of verifying your identity in fulcio
git commit -s --allow-empty --message="Signed commit by $(whoami)"

# Let's look at our signature and validate this commit
git --no-pager log --show-signature -1

# Now let's validate things the hard way! Let's get the UUID of the commit and look it up in rekor
export uuid=$(rekor-cli search --artifact <(git rev-parse HEAD | tr -d '\n') | tail -n 1)
rekor-cli get --uuid=$uuid --format=json | jq .

# With that UUID, we can look up the signature content (also in rekor) and validate things with cosign
export sig=$(rekor-cli get --uuid=$uuid --format=json | jq -r .Body.HashedRekordObj.signature.content)
export cert=$(rekor-cli get --uuid=$uuid --format=json | jq -r .Body.HashedRekordObj.signature.publicKey.content)
cosign verify-blob --certificate-identity-regexp=".*" --certificate-oidc-issuer-regexp=".*" --cert <(echo $cert | base64 --decode) --signature <(echo $sig | base64 --decode) <(git rev-parse HEAD | tr -d '\n')

# Lastly, we can output the certificate fulcio issued us, and find our email address
echo $cert | base64 --decode | openssl x509 -text

git checkout main && git branch -D demo-test-branch