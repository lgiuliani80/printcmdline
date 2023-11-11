@echo off
for /f "tokens=*" %%a in ('vswhere -property installationPath') do (
    set VS_PATH=%%a
)
for /f "tokens=*" %%a in ('dir /b /s "%VS_PATH%\ml64.exe"') do (
    set ML64_PATH=%%a
)
for /f "tokens=*" %%a in ('dir /b /s "%VS_PATH%\ml.exe"') do (
    set ML32_PATH=%%a
)

"%ML64_PATH%" printcmdline64.asm /link "%ProgramFiles(x86)%\Microsoft SDKs\Windows\v7.1A\Lib\x64\Kernel32.Lib" /subsystem:console
"%ML32_PATH%" printcmdline32.asm /link "%ProgramFiles(x86)%\Microsoft SDKs\Windows\v7.1A\Lib\Kernel32.Lib" /subsystem:console
