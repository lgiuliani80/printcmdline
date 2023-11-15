@echo off

vswhere -property installationPath 2>NUL >NUL
if ERRORLEVEL 1 (
    echo "vswhere.exe not found in system path. Please make sure both Visual Studio and vswhere are installed."
    echo "You can install vswhere via WinGET:"
    echo "   winget install Microsoft.VisualStudio.Locator"
    echo "or Chocolatey:"
    echo "   choco install vswhere"
    echo.
    exit /b 1
)

for /f "tokens=*" %%a in ('vswhere -property installationPath') do (
    set VS_PATH=%%a
)
for /f "tokens=*" %%a in ('dir /b /s "%VS_PATH%\ml64.exe"') do (
    set ML64_PATH=%%a
)
for /f "tokens=*" %%a in ('dir /b /s "%VS_PATH%\ml.exe"') do (
    set ML32_PATH=%%a
)

if "%ML64_PATH%" == "" (
    echo "Microsoft Macro Assembler 64 bit (ml64.exe) not found"
    exit /b 1
)

if "%ML32_PATH%" == "" (
    echo "Microsoft Macro Assembler 32 bit (ml.exe) not found"
    exit /b 1
)

if not exist "%ProgramFiles(x86)%\Microsoft SDKs\Windows\v7.1A\Lib\x64\Kernel32.Lib" (
    echo "Microsoft Windows SDK 7.1A not found [64 bits folder]"
    exit /b 1
)

if not exist "%ProgramFiles(x86)%\Microsoft SDKs\Windows\v7.1A\Lib\Kernel32.Lib" (
    echo "Microsoft Windows SDK 7.1A not found [32 bits folder]"
    exit /b 1
)

"%ML64_PATH%" printcmdline64.asm /link "%ProgramFiles(x86)%\Microsoft SDKs\Windows\v7.1A\Lib\x64\Kernel32.Lib" /subsystem:console
if errorlevel 1 (
    echo "ml64.exe failed to assemble printcmdline64.asm"
    exit /b 1
)
"%ML64_PATH%" printcmdline64plus.asm /link "%ProgramFiles(x86)%\Microsoft SDKs\Windows\v7.1A\Lib\x64\Kernel32.Lib" "%ProgramFiles(x86)%\Microsoft SDKs\Windows\v7.1A\Lib\x64\User32.Lib" "%ProgramFiles(x86)%\Microsoft SDKs\Windows\v7.1A\Lib\x64\Shell32.Lib" /subsystem:console
if errorlevel 1 (
    echo "ml64.exe failed to assemble printcmdline64plus.asm"
    exit /b 1
)

"%ML32_PATH%" printcmdline32.asm /link "%ProgramFiles(x86)%\Microsoft SDKs\Windows\v7.1A\Lib\Kernel32.Lib" /subsystem:console
if errorlevel 1 (
    echo "ml.exe failed to assemble printcmdline32.asm"
    exit /b 1
)
