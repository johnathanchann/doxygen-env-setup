#!/bin/bash
echo "Cloning the repository..."
git clone https://x-access-token:${GITHUB_TOKEN}@github.com/${{ github.repository }} repo
cd repo

# Check if the gh-pages branch exists
if git show-ref --verify --quiet refs/heads/gh-pages; then
    echo "Switching to gh-pages branch..."
    git checkout gh-pages
else
    echo "Creating gh-pages branch..."
    git checkout --orphan gh-pages
    git rm -rf .
    touch .gitkeep
    git add .gitkeep
    git commit -m "Initial commit on gh-pages branch"
    git push origin gh-pages
fi

echo "Cleaning up the old files..."
find . -maxdepth 1 ! -name '.git' ! -name '.' -exec rm -rf {} +

echo "Copying the new documentation..."
cp -r ../doc/html/* .

echo "Adding changes..."
git add .
echo "Check if there's changes..."
if git diff-index --quiet HEAD; then
    echo "No changes to commit."
    exit 0
fi

echo "Committing changes..."
git commit -m "Deploy updated documentation"

echo "Pushing changes to gh-pages branch..."
git push origin gh-pages --force

echo "Done"
