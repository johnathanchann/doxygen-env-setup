#!/bin/bash
set -e

echo "Cloning the repository..."
REPO_URL="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git clone "${REPO_URL}" repo
cd repo

echo "Initializing submodules..."
git submodule init

# Check if gh-pages branch exists
if git show-ref --quiet refs/heads/gh-pages; then
    git checkout gh-pages
else
    git checkout --orphan gh-pages
fi

# Clean the directory
git rm -rf . > /dev/null 2>&1

# Copy new documentation
cp -r ../doc/html/* .

# Add and commit changes
git add .
git commit -m "Deploy updated documentation"

# Push changes to the gh-pages branch
git push --force "${REPO_URL}" gh-pages
