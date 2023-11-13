GetCommandLineA PROTO
lstrlen         PROTO lpString:DWORD
GetStdHandle    PROTO nStdHandle:DWORD
WriteFile       PROTO hFile:DWORD, lpBuffer:DWORD, nNumberOfBytesToWrite:DWORD, lpNumberOfBytesWritten:DWORD, lpOverlapped:DWORD
ExitProcess     PROTO nExitCode:DWORD

.data
    crlf db 13, 10

.code
 
    mainCRTStartup PROC
        call    GetCommandLineA
        mov     r11, rax
        mov     rcx, rax
        call    lstrlen
        mov     r12, rax
        mov     rcx, -11
        call    GetStdHandle
        mov     rbx, rax
        mov     rcx, rax
        mov     rdx, r11
        mov     r8, r12
        xor     r9, r9
        push    r9
        call    WriteFile
        mov     rcx, rbx
        lea     rdx, crlf
        mov     r8, 2
        xor     r9, r9
        call    WriteFile
        pop     rax

        xor     rcx, rcx
        call    ExitProcess

    mainCRTStartup  ENDP

END