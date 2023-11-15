GetCommandLineW    PROTO
lstrlenW           PROTO lpString:QWORD
GetStdHandle       PROTO nStdHandle:QWORD
WriteConsoleW      PROTO hConsoleOutput:QWORD, lpBuffer:QWORD, nNumberOfBytesToWrite:DWORD, lpNumberOfBytesWritten:QWORD, lpReserved:QWORD
ExitProcess        PROTO nExitCode:DWORD
CommandLineToArgvW PROTO lpCmdLine:QWORD, lNumArgs:QWORD
wsprintfW          PROTO pszDest:QWORD, pszFormat:QWORD

.const
    crlf    db 13, 0, 10, 0
    fmt     db "%", 0 ,"0", 0, "2", 0, "d", 0, ".", 0, " ", 0, 0, 0

.data
    numargs dd 0
    tmps    db 22 * 2 DUP(0)

.code
 
    mainCRTStartup PROC
        sub     rsp, 8

        call    GetCommandLineW
        mov     r13, rax
        mov     rcx, rax
        call    lstrlenW
        mov     r12, rax
        mov     rcx, -11
        call    GetStdHandle
        mov     rbx, rax
        mov     rcx, rax
        mov     rdx, r13
        mov     r8, r12
        xor     r9, r9
        push    r9
        call    WriteConsoleW
        mov     rcx, rbx
        lea     rdx, crlf
        mov     r8, 2
        xor     r9, r9
        call    WriteConsoleW
        mov     rcx, rbx
        lea     rdx, crlf
        mov     r8, 2
        xor     r9, r9
        call    WriteConsoleW
        pop     rax

        mov     rcx, r13
        lea     rdx, [numargs]
        call    CommandLineToArgvW
        mov     r12, rax
        mov     esi, numargs
        mov     rdi, 0

loopargs:
        lea     rcx, tmps
        lea     rdx, fmt
        mov     r8, rdi
        call    wsprintfW
        lea     rcx, tmps
        call    lstrlenW

        mov     rcx, rbx
        lea     rdx, tmps
        mov     r8, rax
        xor     r9, r9
        push    r9
        call    WriteConsoleW
        pop     r9

        mov     rcx, [r12]
        call    lstrlenW
        mov     rcx, rbx
        mov     rdx, [r12]
        mov     r8, rax
        xor     r9, r9
        push    r9
        call    WriteConsoleW
        mov     rcx, rbx
        lea     rdx, crlf
        mov     r8, 2
        xor     r9, r9
        call    WriteConsoleW
        pop     rax

        add     r12,8
        inc     rdi
        dec     esi
        jnz     loopargs

        xor     rcx, rcx
        call    ExitProcess

        add     rsp, 8

    mainCRTStartup  ENDP

END