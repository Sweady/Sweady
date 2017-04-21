#!/usr/bin/env bash

hugo -b https://sweady.xyz
mkdir deploy && cd deploy
git init && git remote add origin git@github.com:Sweady/Sweady.git && git checkout -b gh-pages
rm -rf *                      # Clear old verion
cp -r ../public/* .             # Copy over files for new version
git add -A .
git commit -m 'Site updated wich Travis'    # Make a new commit for new version
git branch -m gh-pages
git push -q -u origin gh-pages --force  # Push silently so we don't leak information

# Clean
cd ..
rm -rf deploy public