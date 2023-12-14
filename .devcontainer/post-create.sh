#!/bin/bash

WORKSPACE_DIR=$(pwd)

cd ${HOME}

PYTHON_INTERPRETER_PATH="$(poetry env info --path)/bin/python"

cd ${WORKSPACE_DIR}

poetry env use ${PYTHON_INTERPRETER_PATH}
poetry install --only=main --no-root

echo "Post Create Done!"
