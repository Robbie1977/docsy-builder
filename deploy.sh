#Copyright 2018 Google LLC
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
#
HUGO_ENV="production"

cd /src/

git submodule add https://github.com/google/docsy.git themes/docsy
cd themes/docsy
git checkout v0.6.0

npm install --global yarn

npm install --save-dev autoprefixer postcss-cli postcss

cd /src/themes/docsy

npm install

cd /src/

tree /src/

hugo mod clean --all

hugo mod graph

rm -rf public/
HUGO_ENV="production" hugo --enableGitInfo --minify --templateMetrics --gc -v || exit 1
s3deploy -source=public/ -region=eu-west-1 -bucket=bep.is -distribution-id=E8OKNT7W9ZYZ2 -path temp/td
