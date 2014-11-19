set str=%~dp0

rmdir /S /Q %str%\.deploy
hexo clean
echo off
pause

