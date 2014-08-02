#!/bin/bash

echo -e "\033[0;32mDeploying updates to Github...\033[0m"

# Build the project.
#hugo
hugo --uglyUrls=true -t hyde 

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

#git subtree add --prefix public git@github.com:j4/j4.github.io.git master --squash
#git subtree pull --prefix=public

# Push source and build repos.
git push origin master
git subtree push --prefix=public git@github.com:j4/j4.github.io.git gh-pages
