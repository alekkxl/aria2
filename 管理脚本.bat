@echo off
%~dp0说明.txt
color 2e
echo ========================================  
echo #          Power By WZC                #  
echo #            安装选项:                 #  
echo #            1- 安装                   #  
echo #            2- 停止程序               #  
echo #            3- 重启程序               # 
echo #            4- 设置开机启动           #
echo #            5- 移除开机启动项         # 
echo #            6- 卸载                   #  
echo ========================================  
set choice=
set /p choice=    请输入选项（1/2/3/4/5/6）：
goto %choice%
exit

:1
echo 安装
cd %~dp0\Aria2
echo 设置下载地址
set choice1=
set /p choice1= （1:默认为%~dp0Aria2\Download  2：自定义）：
if "%choice1%"=="2" (
goto 7
) else (
goto 10
)
:7
set /p dizhi=请输入Aria2下载路径：
echo dir=%dizhi% >> %~dp0\Aria2\aria2.conf
echo save-session=%~dp0Aria2\aria2.session>> %~dp0\Aria2\aria2.conf
echo input-file=%~dp0Aria2\aria2.session>> %~dp0\Aria2\aria2.conf
goto 11
:10
echo dir=%~dp0Aria2\Download>> %~dp0\Aria2\aria2.conf
echo save-session=%~dp0Aria2\aria2.session>> %~dp0\Aria2\aria2.conf
echo input-file=%~dp0Aria2\aria2.session>> %~dp0\Aria2\aria2.conf
goto 11
:11
echo 设置密码 默认为16位随机数
setlocal enabledelayedexpansion
set "svar=abcdefghijklmnopqrstuvwxyzABCDEFGOPQRSTUVWXYZ012345679
set "rvar="
set num=16
:loop
set /a num-=1
set /a rand=%random%%%54
set "rvar=%rvar%!svar:~%rand%,1!"
if not %num%==0 goto loop
echo 当前密码为:!rvar!
echo rpc-secret=%rvar%>> %~dp0\Aria2\aria2.conf
set aria=CreateObject("WScript.Shell").Run "%~dp0Aria2\aria2c.exe --conf-path=%~dp0Aria2\aria2.conf",0
echo %aria% >%~dp0\Aria2\aria.vbs
echo >%~dp0\Aria2\aria2.session
%~dp0\Aria2\aria.vbs
echo %rvar%>%~dp0密码.txt
echo 按任意键退出
set cho=
set /p cho=
exit


:4
echo 设置开机启动
set rege="HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"
reg add %rege% /v aria /t reg_sz /d "%~dp0Aria2\aria.vbs" /f
pause
exit

:2
echo 停止程序
taskkill /IM aria2c.exe /f /t
pause
exit

:3
echo 重启程序
taskkill /IM aria2c.exe /f /t
%~dp0\Aria2\aria.vbs
pause
exit

:5
set rege="HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"
reg delete %rege% /v aria
pause
exit

:6
echo 如果下载地址为默认地址，请将下载文件夹移出
echo 关闭程序
taskkill /IM aria2c.exe /f /t
echo 移除文件
del /f /s /q %~dp0\Aria2\*
echo 移除启动项
set rege="HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"
reg delete %rege% /v aria
pause
exit