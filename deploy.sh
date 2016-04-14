#!/bin/bash
set -e # exit with nonzero exit code if anything fails

# squash messages
git config --global push.default matching

# clear and re-create the out directory
rm -rf out || exit 0;
mkdir out;

# go to the out directory 
cd out

# get existing gh-pages
git clone "https://${GH_TOKEN}@${GH_REF}"

cd openactive.github.io

# inside this git repo we'll pretend to be a new user
git config user.name "Travis CI"
git config user.email "travis@openactive.org"

# unzip
unzip -o openactive-demonstrator.webflow.zip

# (hack for now!) add a date to ensure there's always something to push!
date > timestamp.txt

git add .
git commit -m "Deploy to GitHub Pages"

git push --force --quiet "https://${GH_TOKEN}@${GH_REF}"

