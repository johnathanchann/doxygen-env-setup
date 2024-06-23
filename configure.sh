#!/bin/bash
set -e
echo "Cloning the repository..."
git clone https://x-access-token:${GITHUB_TOKEN}@github.com/${{ github.repository }} repo
cd repo
git checkout --orphan gh-pages
git rm -rf .
cp -r ../doc/html/* .
git add .
git commit -m "Deploy updated documentation"
git pull origin gh-pages --rebase
git push --force "${REPO_URL}" gh-pages
