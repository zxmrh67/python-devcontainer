FROM mcr.microsoft.com/devcontainers/base:jammy

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=vscode

ENV DOCKER_BUILDKIT=1

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y build-essential --no-install-recommends make \
        ca-certificates \
        git \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        wget \
        curl \
        llvm \
        libncurses5-dev \
        xz-utils \
        tk-dev \
        libxml2-dev \
        libxmlsec1-dev \
        libffi-dev \
        liblzma-dev

USER $USER
ARG HOME="/home/$USER"
ARG PYTHON_VERSION=3.11

ENV PYENV_ROOT="${HOME}/.pyenv"
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${HOME}/.local/bin:$PATH"

RUN curl https://pyenv.run | bash \
    && pyenv install ${PYTHON_VERSION} \
    && pyenv global ${PYTHON_VERSION}

ENV PIP_X_VERSION=1.3.3 \
    POETRY_VERSION=1.7.1

RUN python3 -m pip install --user pip "pipx==$PIP_X_VERSION" && \
    python3 -m pipx ensurepath
RUN python3 -m pipx install "poetry==$POETRY_VERSION"

RUN pipx inject poetry poetry-plugin-sort
RUN pipx inject poetry "poetry-dynamic-versioning[plugin]"

WORKDIR ${HOME}

COPY poetry.lock pyproject.toml ./

# can not use in project venv because of bind mount
RUN poetry config virtualenvs.in-project false && \
    poetry config virtualenvs.options.no-pip true && \
    poetry config virtualenvs.options.no-setuptools true && \
    poetry install --only=main --no-root

SHELL ["/bin/bash", "-c", "source $(poetry env info --path)/bin/activate"]

RUN poetry run pre-commit install
