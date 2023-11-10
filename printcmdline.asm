GetCommandLineW PROTO
lstrlenW PROTO
GetStdHandle PROTO
WriteFile PROTO
ExitProcess PROTO

.data
    crlf db 13, 0, 10, 0

.code
 
    mainCRTStartup PROC
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32

        call    GetCommandLineW
        mov     qword ptr [rbp], rax
        mov     rcx, rax
        call    lstrlenW
        mov     qword ptr [rbp + 8], rax
        mov     rcx, -11
        call    GetStdHandle
        mov     rbx, rax
        mov     rcx, rax
        mov     rdx, qword ptr [rbp]
        mov     r8, qword ptr [rbp + 8]
        shl     r8, 1
        xor     r9, r9
        xor     rax,rax
        push    rax
        call    WriteFile
        mov     rcx, rbx
        lea     rdx, crlf
        mov     r8, 4
        xor     r9, r9
        call    WriteFile
        pop     rax

        xor     rax, rax
        call    ExitProcess
    mainCRTStartup  ENDP

END