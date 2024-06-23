#!/bin/bash
set -e
echo "Cloning the repository..."
REPO_URL="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git clone "${REPO_URL}" repo
cd repo
git checkout --orphan gh-pages
git rm -rf .
cp -r ../doc/html/* .
git add .
git commit -m "Deploy updated documentation"
git pull origin gh-pages --rebase
git push --force "${REPO_URL}" gh-pages
