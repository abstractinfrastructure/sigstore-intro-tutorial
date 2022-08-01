# sigstore Tutorials

## Before you begin
These tutorials accompany the presentation [Supply Chain Security Tooling](https://docs.google.com/presentation/d/1Z15Z2GElaoy0kobb8oTM-RLgkTd270iyKA0zscO9nJY/edit#slide=id.p)

## Demo depdendencies
- git
- docker (https://docs.docker.com/engine/install/#desktop)
- kind (https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- helm (https://helm.sh/docs/intro/install/)
- cosign (https://docs.sigstore.dev/cosign/installation/)

Bonus Dependencies:
- openssl
- rekor-cli (https://docs.sigstore.dev/rekor/installation)
- gitsign (https://docs.sigstore.dev/gitsign/installation)

---

## Tutorial Index
* [cosign](1-cosign/) - Covers the basics of signing and verifying container images with the `cosign` utility
* [controller](2-controller/) - Install and secure a Kubernetes namespace with the sigstore `policy-controller`
* [github-action](.github/workflows/docker-signed-build.yml) - Use a GitHub Action to build, push, and sign a container while capturing and validating provenance (walkthrough, not a demo)
* [gitsign](4-gitsign/) - Secure your code at commit-time by signing commits with an OIDC identity.