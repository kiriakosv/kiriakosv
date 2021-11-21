#!/bin/bash

if [[ `git status --porcelain` ]]; then
  git config --global user.name "The Bot 🤖"
  git config --global user.email "the-bot@example.com"
  git add .
  git commit -am "Update content" || exit 0
  git push
fi
