#空项目预置环境

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
pnpm docs:build

# 进入生成的文件夹
cd src/.vuepress/dist

# 如果是发布到自定义域名
echo 'arclib.top' > CNAME

git init
git add .

git commit -m "deploy commit"
# 如果发布到 https://<USERNAME>.github.io
git push -f git@github.com:arclib/arclib.github.io.git master:gh-pages

# 如果发布到 https://<USERNAME>.github.io/<REPO>
# git push -f git@github.com:<USERNAME>/<REPO>.git master:gh-pages

cd -
