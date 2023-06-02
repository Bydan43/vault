FROM alpine:3.18.0

ARG VAULT_VERSION

RUN mkdir /vault

RUN apk --no-cache add \
      bash \
      ca-certificates \
      wget \
      curl

RUN wget --quiet --output-document=/tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
    unzip /tmp/vault.zip -d /vault && \
    rm -f /tmp/vault.zip && \
    chmod +x /vault

ENV PATH="PATH=$PATH:$PWD/vault"

COPY ./config/vault-server.hcl /vault/config/vault-server.hcl

EXPOSE 8200

ENTRYPOINT ["vault"]
