@ECHO OFF
setlocal

REM ���̃o�b�`�t�@�C���Ɠ����K�w��PowerShell�X�N���v�g�t�@�C�����u����Ă���O��
set mydir=%~dp0
set pspath=%mydir%PsrWrapper.ps1

rem �w�肳�ꂽps1�����s����
rem set pspath=%1

REM -ExecutionPolicy �ꎞ�I�Ɏ��s�|���V�[���ɘa����
REM https://qiita.com/tomoko523/items/df8e384d32a377381ef9
powershell -NoProfile -ExecutionPolicy Bypass %pspath%

REM �I��
PAUSE
endlocal
rem exit
