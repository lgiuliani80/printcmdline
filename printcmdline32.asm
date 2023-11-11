.686p
.XMM
.model flat, STDCALL

GetCommandLineA PROTO STDCALL
lstrlen         PROTO STDCALL, lpString:DWORD
GetStdHandle    PROTO STDCALL, nStdHandle:DWORD
WriteFile       PROTO STDCALL, hFile:DWORD, lpBuffer:DWORD, nNumberOfBytesToWrite:DWORD, lpNumberOfBytesWritten:DWORD, lpOverlapped:DWORD
ExitProcess     PROTO STDCALL, nExitCode:DWORD

.data
    crlf db 13, 10

.code

    mainCRTStartup PROC FAR
        mov     ebp, esp
        sub     esp, 12

        call    GetCommandLineA
        mov     dword ptr [ebp - 4], eax
        push    eax
        call    lstrlen
        mov     dword ptr [ebp - 8], eax
        mov     eax, -11
        push    eax
        call    GetStdHandle
        mov     ebx, eax
        xor     esi, esi
        push    esi
        push    esi
        push    dword ptr [ebp - 8]
        push    dword ptr [ebp - 4]
        push    ebx
        call    WriteFile
        push    esi
        push    esi
        mov     eax, 2
        push    eax
        lea     eax, crlf
        push    eax
        push    ebx
        call    WriteFile

        xor     eax, eax
        call    ExitProcess

    mainCRTStartup  ENDP

END