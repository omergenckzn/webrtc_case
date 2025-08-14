#!/bin/bash

# Ensure .gitignore exists
if [ ! -f .gitignore ]; then
  echo ".gitignore file not found!"
  exit 1
fi

# Remove all ignored files from Git tracking
echo "Removing ignored files from Git..."
git rm -r --cached $(git ls-files --ignored --exclude-standard)

# Confirm and commit changes
echo "Committing changes..."
git commit -m "Removed ignored files from Git tracking"

echo "Done!"
