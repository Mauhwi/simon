# deploy.sh

#!/usr/bin/env sh

# abort on errors
set -e

echo Linting..
npm run lint
echo Building. this may take a minute...
npm run build

cd dist

echo Deploying..
git init
git add -A
git commit -m 'deploy'

git push -f git@github.com:Mauhwi/simon.git master:gh-pages

cd -