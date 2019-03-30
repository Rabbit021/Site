@echo off
echo 开始安装
echo f| npm install hexo-cli -g
echo f| npm install hexo --save

echo f| npm install hexo-generator-index --save
echo f| npm install hexo-generator-archive --save
echo f| npm install hexo-generator-category --save
echo f| npm install hexo-generator-tag --save
echo f| npm install hexo-generator-feed@1 --save
echo f| npm install hexo-generator-sitemap@1 --save

echo f| npm install hexo-server --save

echo f| npm install hexo-deployer-git --save

echo f| npm install hexo-deployer-heroku --save
echo f| npm install hexo-deployer-rsync --save
echo f| npm install hexo-deployer-openshift --save

echo f| npm install hexo-renderer-jade@0.3.0 --save
echo f| npm install hexo-renderer-stylus --save
echo f| npm install hexo-renderer-marked@0.2 --save
echo f| npm install hexo-renderer-stylus@0.2 --save

echo 安装完成
@pause
