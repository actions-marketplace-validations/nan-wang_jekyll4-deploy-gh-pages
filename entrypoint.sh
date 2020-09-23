#!/bin/bash

set -e

DEST="${JEKYLL_DESTINATION:-_site}"
BUNDLE_BUILD__SASSC=--disable-march-tune-native

echo "Installing gems..."

bundle config path vendor/bundle
bundle install --jobs 4 --retry 3

echo "Building Jekyll site..."

JEKYLL_ENV=production bundle exec jekyll build

cd ${DEST}

git init
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR_EMAIL}"
touch .nojekyll
echo ${CUSTOM_DOMAIN} > CNAME
git add .
git commit -m "published by GitHub Actions"
