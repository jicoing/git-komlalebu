#!/bin/bash

set -e

# Respect AWS_DEFAULT_REGION if specified
[ -n "$AWS_DEFAULT_REGION" ] || export AWS_DEFAULT_REGION=ap-south-1

# Respect AWS_DEFAULT_OUTPUT if specified
[ -n "$AWS_DEFAULT_OUTPUT" ] || export AWS_DEFAULT_OUTPUT=json

VERSION=$(git describe --exact-match --tags)

if ! [[ $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Tag is not a semantic version: $VERSION"
    exit 1
fi

ARGS=()

ARGS+=( "--template $INPUT_TEMPLATE" )
ARGS+=( "--semantic-version \"$VERSION\"" )

CMD="sam publish ${ARGS[@]}"

output=$( sh -c "$CMD" )

# Preserve output for consumption by downstream actions
echo "$output" > "${HOME}/${GITHUB_ACTION}.${AWS_DEFAULT_OUTPUT}"

# Write output to STDOUT
echo "$output"