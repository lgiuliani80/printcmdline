GetCommandLineA PROTO
lstrlen PROTO
GetStdHandle PROTO
WriteFile PROTO
ExitProcess PROTO

.data
    crlf db 13, 10

.code
 
    mainCRTStartup PROC
        mov     rbp, rsp
        sub     rsp, 32

        call    GetCommandLineA
        mov     qword ptr [rbp], rax
        mov     rcx, rax
        call    lstrlen
        mov     qword ptr [rbp + 8], rax
        mov     rcx, -11
        call    GetStdHandle
        mov     rbx, rax
        mov     rcx, rax
        mov     rdx, qword ptr [rbp]
        mov     r8, qword ptr [rbp + 8]
        xor     r9, r9
        push    r9
        call    WriteFile
        mov     rcx, rbx
        lea     rdx, crlf
        mov     r8, 2
        xor     r9, r9
        call    WriteFile
        pop     rax

        xor     rax, rax
        call    ExitProcess

    mainCRTStartup  ENDP

END