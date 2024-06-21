#!/bin/bash
echo "Cloning the repository and checking out the gh-pages branch..."
git clone --branch=gh-pages https://x-access-token:${GITHUB_TOKEN}@github.com/${{ github.repository }} gh-pages
cd gh-pages

echo "Cleaning up the old files..."
find . -maxdepth 1 ! -name '.git' ! -name '.' -exec rm -rf {} +

echo "Copying the new documentation..."
cp -r ../doc/html/* .

echo "Adding changes..."
git add .
if git diff-index --quiet HEAD; then
   echo "No changes to commit."
   exit 0
fi

echo "Committing changes..."
git commit -m "Deploy updated documentation"

echo "Pushing changes to gh-pages branch..."
git push origin gh-pages --force
