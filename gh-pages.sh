#!/bin/sh
# Generate documentation and deploy it to GitHub pages
# http://TxHawks.github.io/jigsass-utils-type/
gulp sass:sg
git add ./docs/.
git commit -m "Compile documentation"
git subtree push --prefix docs/styleguide origin gh-pages
