#!/bin/sh
set -eu

git ls-files | grep -E "\.sh$" | xargs shellcheck

hadolint Dockerfile.template
