#!/bin/bash
# Simple script to add all git repo folders in the current directory as git submodules
#
# Assumptions:
#   * current directory is already part of a git repo
#   * all folders in the current path are git repos
#
# By anupdhml

for repo in *;do
  # skip over non-directories
  [ ! -d "$repo" ] && continue

  echo "Adding repo folder ${repo}..."

  pushd "$repo" > /dev/null
  url=$(git remote get-url $(git remote | head -n1))
  popd > /dev/null

  echo "Remote url: ${url}"
  git submodule add $url "./${repo}"
  echo ""
done
