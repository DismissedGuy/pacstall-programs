#!/bin/bash

## Update master branch
git fetch upstream
git checkout master
git merge upstream/master
git push


## Update package(s)
for i in "$@"; do
  pacup -s "${i}"

  BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  git push --set-upstream origin "${BRANCH}" --force

  gh pr create --repo pacstall/pacstall-programs --fill
done

git checkout master
