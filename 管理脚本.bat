@echo off
%~dp0˵��.txt
color 2e
echo ========================================  
echo #          Power By WZC                #  
echo #            ��װѡ��:                 #  
echo #            1- ��װ                   #  
echo #            2- ֹͣ����               #  
echo #            3- ��������               # 
echo #            4- ���ÿ�������           #
echo #            5- �Ƴ�����������         # 
echo #            6- ж��                   #  
echo ========================================  
set choice=
set /p choice=    ������ѡ�1/2/3/4/5/6����
goto %choice%
exit

:1
echo ��װ
cd %~dp0\Aria2
echo �������ص�ַ
set choice1=
set /p choice1= ��1:Ĭ��Ϊ%~dp0Aria2\Download  2���Զ��壩��
if "%choice1%"=="2" (
goto 7
) else (
goto 10
)
:7
set /p dizhi=������Aria2����·����
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
echo �������� Ĭ��Ϊ16λ�����
setlocal enabledelayedexpansion
set "svar=abcdefghijklmnopqrstuvwxyzABCDEFGOPQRSTUVWXYZ012345679
set "rvar="
set num=16
:loop
set /a num-=1
set /a rand=%random%%%54
set "rvar=%rvar%!svar:~%rand%,1!"
if not %num%==0 goto loop
echo ��ǰ����Ϊ:!rvar!
echo rpc-secret=%rvar%>> %~dp0\Aria2\aria2.conf
set aria=CreateObject("WScript.Shell").Run "%~dp0Aria2\aria2c.exe --conf-path=%~dp0Aria2\aria2.conf",0
echo %aria% >%~dp0\Aria2\aria.vbs
echo >%~dp0\Aria2\aria2.session
%~dp0\Aria2\aria.vbs
echo %rvar%>%~dp0����.txt
echo ��������˳�
set cho=
set /p cho=
exit


:4
echo ���ÿ�������
set rege="HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"
reg add %rege% /v aria /t reg_sz /d "%~dp0Aria2\aria.vbs" /f
pause
exit

:2
echo ֹͣ����
taskkill /IM aria2c.exe /f /t
pause
exit

:3
echo ��������
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
echo ������ص�ַΪĬ�ϵ�ַ���뽫�����ļ����Ƴ�
echo �رճ���
taskkill /IM aria2c.exe /f /t
echo �Ƴ��ļ�
del /f /s /q %~dp0\Aria2\*
echo �Ƴ�������
set rege="HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"
reg delete %rege% /v aria
pause
exit