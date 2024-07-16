#!/bin/bash
set -e

# Checkout gh-pages
git checkout -b gh-pages

# Clean the directory
find . -mindepth 1 -maxdepth 1 ! -name 'doc' -exec rm -rf {} +

# Copy new documentation
cp -r ../doc/html/* .

# Add and commit changes
git add .
git commit -m "Deploy updated documentation"

# Push changes to the gh-pages branch
git push --force "${REPO_URL}" gh-pages
