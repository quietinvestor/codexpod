FROM ubuntu:24.04@sha256:67efaecc0031a612cf7bb3c863407018dbbef0a971f62032b77aa542ac8ac0d2

ARG CODEX_VERSION=0.118.0
ARG DEBIAN_FRONTEND=noninteractive
ARG NODE_VERSION=v25.8.1

RUN apt-get update && apt-get install --yes --no-install-recommends \
    bind9-dnsutils=1:9.18.39-0ubuntu0.24.04.3 \
    bubblewrap=0.9.0-1ubuntu0.1 \
    ca-certificates=20240203 \
    curl=8.5.0-2ubuntu10.8 \
    git=1:2.43.0-1ubuntu7.3 \
    gnupg=2.4.4-2ubuntu17.4 \
    iputils-ping=3:20240117-1ubuntu0.1 \
    iputils-tracepath=3:20240117-1ubuntu0.1 \
    libatomic1=14.2.0-4ubuntu2~24.04.1 \
    netcat-openbsd=1.226-1ubuntu2 \
    openssl=3.0.13-0ubuntu3.7 \
    ripgrep=14.1.0-1 \
    traceroute=1:2.1.5-1 \
    unzip=6.0-28ubuntu4.1 \
    xz-utils=5.6.1+really5.4.5-1ubuntu0.2 \
    && rm --recursive --force /var/lib/apt/lists/*

WORKDIR /opt

RUN curl --fail --location --output node-${NODE_VERSION}-linux-x64.tar.xz --silent --show-error \
    https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz \
    && tar --extract --file node-${NODE_VERSION}-linux-x64.tar.xz --directory /opt \
    && mv /opt/node-${NODE_VERSION}-linux-x64 /opt/node \
    && rm --force /opt/node-${NODE_VERSION}-linux-x64.tar.xz

ENV PATH=/opt/node/bin:${PATH}

RUN npm --version \
    && npm install --global @openai/codex@${CODEX_VERSION}

RUN groupadd --gid 1001 codex \
    && useradd --create-home --gid 1001 --uid 1001 --shell /bin/bash codex

USER codex

RUN cat >> /home/codex/.bash_profile <<'EOF'

if [ -d /home/codex/.secrets ]; then
    for file in /home/codex/.secrets/*; do
        [ -f "${file}" ] && . "${file}"
    done
fi
EOF

WORKDIR /home/codex/projects

CMD ["/bin/bash"]
