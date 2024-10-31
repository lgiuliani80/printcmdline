.section .data
newline: .byte 10

.section .bss
buffer: .space 128

.section .text
.global _start


_start:
    # Read command line arguments
    movq %rsp, %rbp
    movq %rbp, %rbx
    movq (%rbx), %r12
    addq $8, %rbx

print_parameter:
    movq (%rbx), %rsi
    xorq %rdx, %rdx
    mov %rsi, %rax

strlen_loop:
    cmpb $0, (%rax)
    jz do_print
    incq %rdx
    incq %rax
    jmp strlen_loop

do_print:
    # Write command line arguments to stdout
    movq $1, %rax          # sys_write
    movq $1, %rdi          # file descriptor (stdout)
    # %rsi                 # buffer
    syscall

    # Write newline to stdout
    movq $1, %rax          # sys_write
    movq $1, %rdi          # file descriptor (stdout)
    movq $newline, %rsi    # buffer
    movq $1, %rdx          # number of bytes to write
    syscall

    addq $8, %rbx
    decq %r12
    jnz print_parameter

    # Exit the process
    movq $60, %rax         # sys_exit
    xor %rdi, %rdi        # exit code 0
    syscall
