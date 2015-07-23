cls
@echo off
cls
@color 0a

goto menu
:menu
echo.
echo.               =-=-=-=-=批处理菜单示例=-=-=-=-=
echo.
echo.                       1  安装
echo.
echo.                       2  生成
echo.
echo.                       3  部署
echo.
echo.                       4  运行服务
echo.                       
echo.                       5  清除
echo.                       
echo.                       6  退出
echo.输入对应指令

set /p ID=

if "%id%"=="1" call ./Bat/install  goto menu

if "%id%"=="2" call ./Bat/generate goto menu

if "%id%"=="3" call ./Bat/deploy goto menu

if "%id%"=="4" call ./Bat/start goto menu

if "%id%"=="5" call ./Bat/clean goto menu

if "%id%"=="6" exit goto menu

pause 
