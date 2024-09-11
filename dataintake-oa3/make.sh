#!/bin/bash

echo "building redoc API documentation"

# Bundle docs into zero-dependency HTML file
npx @redocly/cli bundle -o jember-oa3.yaml && \
npx @redocly/cli build-docs jember-oa3.yaml -o index.html 