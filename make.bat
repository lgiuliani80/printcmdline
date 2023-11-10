@echo off
for /f "tokens=*" %%a in ('vswhere -property installationPath') do (
    set VS_PATH=%%a
)
for /f "tokens=*" %%a in ('dir /b /s "%VS_PATH%\ml64.exe"') do (
    set ML_PATH=%%a
)
"%ML_PATH%" printcmdline.asm /link "%ProgramFiles(x86)%\Microsoft SDKs\Windows\v7.1A\Lib\x64\Kernel32.Lib" /subsystem:console