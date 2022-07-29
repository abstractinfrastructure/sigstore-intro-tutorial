# sigstore Tutorials

## Before you begin
These tutorials accompany the presentation [Supply Chain Security Tooling](https://docs.google.com/presentation/d/1Z15Z2GElaoy0kobb8oTM-RLgkTd270iyKA0zscO9nJY/edit#slide=id.p)

## Demo depdendencies
- docker
- kind
- helm
- openssl

---

## Tutorial Index
* [cosign](cosign/) - Covers the basics of signing and verifying container images with the `cosign` utility
* [controller](controller/) - Install and secure a Kubernetes namespace with the sigstore `policy-controller`
* [gitsign](gitsign/) - Secure your code at commit-time by signing commits with an OIDC identity.