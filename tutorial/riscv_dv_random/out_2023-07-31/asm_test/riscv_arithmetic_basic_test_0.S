.include "user_define.h"
.globl _start
.section .text
.option norvc;
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x31, h0_start
jalr x0, x31, 0
h0_start:
                  li x27, 0x40000100
                  csrw 0x301, x27
kernel_sp:        
                  la x30, kernel_stack_end

trap_vec_init:    
                  la x27, mtvec_handler
                  ori x27, x27, 0
                  csrw 0x305, x27 # MTVEC

mepc_setup:       
                  la x27, init
                  csrw 0x341, x27

init_machine_mode:
                  li x27, 0x1c00
                  csrw 0x300, x27 # MSTATUS
                  li x27, 0x0
                  csrw 0x304, x27 # MIE
                  mret
init:             
                  li x0, 0x0
                  li x1, 0x0
                  li x2, 0x5a5347ca
                  li x3, 0xa
                  li x4, 0x0
                  li x5, 0x0
                  li x6, 0x4
                  li x7, 0x81a8ee71
                  li x8, 0x2
                  li x9, 0x9
                  li x10, 0xa70a227b
                  li x12, 0x0
                  li x13, 0x0
                  li x14, 0x3
                  li x15, 0x80000000
                  li x16, 0x1f0d8b3d
                  li x17, 0xe
                  li x18, 0x91f11005
                  li x19, 0x80000000
                  li x20, 0x0
                  li x21, 0x0
                  li x22, 0xa
                  li x23, 0x46b597a8
                  li x24, 0xf669fa8b
                  li x25, 0x1
                  li x26, 0xf813dd3a
                  li x27, 0x0
                  li x28, 0xb
                  li x29, 0xf5b596d8
                  li x31, 0xffd606ff
                  la x11, user_stack_end
main:             or          s9, t4, t2
                  sltiu       t4, t3, 1555
                  sll         s2, s7, t6
                  sra         s6, t6, s10
                  li         t4, 0x0 #start riscv_int_numeric_corner_stream_0
                  li         t3, 0x1
                  li         s4, 0x1
                  li         s2, 0x1
                  li         tp, 0x1
                  li         sp, 0x0
                  li         s11, 0x0
                  li         a2, 0x1
                  li         s10, 0x0
                  li         a4, 0x0
                  addi        a7, zero, 881
                  sub         s0, s7, s7
                  lui         t4, 997549
                  sub         t3, s1, tp
                  lui         zero, 114109
                  add         s9, s0, t6
                  addi        a5, s8, 1858
                  nop
                  lui         zero, 251267
                  lui         s8, 953171
                  sub         a7, a2, zero
                  sub         a6, t2, s1
                  lui         s7, 710726
                  lui         t2, 451348
                  addi        s4, gp, 1303
                  lui         ra, 541654
                  lui         zero, 19278
                  lui         t1, 507783
                  lui         s7, 966480
                  addi        gp, s6, 1318
                  nop
                  sub         gp, s0, s9
                  addi        t1, s0, -949
                  addi        gp, tp, -1815 #end riscv_int_numeric_corner_stream_0
                  auipc       s11, 449780
                  xori        sp, s11, -729
                  or          s0, t2, a4
                  sll         a0, s2, s10
                  auipc       t0, 698790
                  xor         zero, t0, t2
                  la x31, test_done
                  jalr x0, x31, 0
test_done:        
                  li gp, 1
                  ecall
write_tohost:     
                  sw gp, tohost, t5

_exit:            
                  j write_tohost

instr_end:        
                  nop

.section .data
.align 6; .global tohost; tohost: .dword 0;
.align 6; .global fromhost; fromhost: .dword 0;
.section .user_stack,"aw",@progbits;
.align 2
user_stack_start:
.rept 4999
.4byte 0x0
.endr
user_stack_end:
.4byte 0x0
.align 2
kernel_instr_start:
.text
.align 2
mtvec_handler:    
                  csrrw x11, 0x340, x11
                  add x11, x30, zero
                  1: addi x11, x11, -124
                  sw x1, 4(x11)
                  sw x2, 8(x11)
                  sw x3, 12(x11)
                  sw x4, 16(x11)
                  sw x5, 20(x11)
                  sw x6, 24(x11)
                  sw x7, 28(x11)
                  sw x8, 32(x11)
                  sw x9, 36(x11)
                  sw x10, 40(x11)
                  sw x11, 44(x11)
                  sw x12, 48(x11)
                  sw x13, 52(x11)
                  sw x14, 56(x11)
                  sw x15, 60(x11)
                  sw x16, 64(x11)
                  sw x17, 68(x11)
                  sw x18, 72(x11)
                  sw x19, 76(x11)
                  sw x20, 80(x11)
                  sw x21, 84(x11)
                  sw x22, 88(x11)
                  sw x23, 92(x11)
                  sw x24, 96(x11)
                  sw x25, 100(x11)
                  sw x26, 104(x11)
                  sw x27, 108(x11)
                  sw x28, 112(x11)
                  sw x29, 116(x11)
                  sw x30, 120(x11)
                  sw x31, 124(x11)
                  csrr x27, 0x300 # MSTATUS
                  csrr x27, 0x342 # MCAUSE
                  srli x27, x27, 31
                  bne x27, x0, mmode_intr_handler

mmode_exception_handler:
                  csrr x27, 0x341 # MEPC
                  csrr x27, 0x342 # MCAUSE
                  li x29, 0xb # ECALL_MMODE
                  beq x27, x29, ecall_handler
                  li x29, 0x2 # ILLEGAL_INSTRUCTION
                  beq x27, x29, illegal_instr_handler
                  csrr x29, 0x343 # MTVAL
                  1: la x31, test_done
                  jalr x1, x31, 0

ecall_handler:    
                  la x27, _start
                  sw x0, 0(x27)
                  sw x1, 4(x27)
                  sw x2, 8(x27)
                  sw x3, 12(x27)
                  sw x4, 16(x27)
                  sw x5, 20(x27)
                  sw x6, 24(x27)
                  sw x7, 28(x27)
                  sw x8, 32(x27)
                  sw x9, 36(x27)
                  sw x10, 40(x27)
                  sw x11, 44(x27)
                  sw x12, 48(x27)
                  sw x13, 52(x27)
                  sw x14, 56(x27)
                  sw x15, 60(x27)
                  sw x16, 64(x27)
                  sw x17, 68(x27)
                  sw x18, 72(x27)
                  sw x19, 76(x27)
                  sw x20, 80(x27)
                  sw x21, 84(x27)
                  sw x22, 88(x27)
                  sw x23, 92(x27)
                  sw x24, 96(x27)
                  sw x25, 100(x27)
                  sw x26, 104(x27)
                  sw x27, 108(x27)
                  sw x28, 112(x27)
                  sw x29, 116(x27)
                  sw x30, 120(x27)
                  sw x31, 124(x27)
                  la x31, write_tohost
                  jalr x0, x31, 0

illegal_instr_handler:
                  csrr  x27, 0x341
                  addi  x27, x27, 4
                  csrw  0x341, x27
                  lw x1, 4(x11)
                  lw x2, 8(x11)
                  lw x3, 12(x11)
                  lw x4, 16(x11)
                  lw x5, 20(x11)
                  lw x6, 24(x11)
                  lw x7, 28(x11)
                  lw x8, 32(x11)
                  lw x9, 36(x11)
                  lw x10, 40(x11)
                  lw x11, 44(x11)
                  lw x12, 48(x11)
                  lw x13, 52(x11)
                  lw x14, 56(x11)
                  lw x15, 60(x11)
                  lw x16, 64(x11)
                  lw x17, 68(x11)
                  lw x18, 72(x11)
                  lw x19, 76(x11)
                  lw x20, 80(x11)
                  lw x21, 84(x11)
                  lw x22, 88(x11)
                  lw x23, 92(x11)
                  lw x24, 96(x11)
                  lw x25, 100(x11)
                  lw x26, 104(x11)
                  lw x27, 108(x11)
                  lw x28, 112(x11)
                  lw x29, 116(x11)
                  lw x30, 120(x11)
                  lw x31, 124(x11)
                  addi x11, x11, 124
                  add x30, x11, zero
                  csrrw x11, 0x340, x11
                  mret

pt_fault_handler: 

.align 2
mmode_intr_handler:
                  csrr  x27, 0x300 # MSTATUS;
                  csrr  x27, 0x304 # MIE;
                  csrr  x27, 0x344 # MIP;
                  csrrc x27, 0x344, x27 # MIP;
                  lw x1, 4(x11)
                  lw x2, 8(x11)
                  lw x3, 12(x11)
                  lw x4, 16(x11)
                  lw x5, 20(x11)
                  lw x6, 24(x11)
                  lw x7, 28(x11)
                  lw x8, 32(x11)
                  lw x9, 36(x11)
                  lw x10, 40(x11)
                  lw x11, 44(x11)
                  lw x12, 48(x11)
                  lw x13, 52(x11)
                  lw x14, 56(x11)
                  lw x15, 60(x11)
                  lw x16, 64(x11)
                  lw x17, 68(x11)
                  lw x18, 72(x11)
                  lw x19, 76(x11)
                  lw x20, 80(x11)
                  lw x21, 84(x11)
                  lw x22, 88(x11)
                  lw x23, 92(x11)
                  lw x24, 96(x11)
                  lw x25, 100(x11)
                  lw x26, 104(x11)
                  lw x27, 108(x11)
                  lw x28, 112(x11)
                  lw x29, 116(x11)
                  lw x30, 120(x11)
                  lw x31, 124(x11)
                  addi x11, x11, 124
                  add x30, x11, zero
                  csrrw x11, 0x340, x11
                  mret;

kernel_instr_end: nop
.align 2
kernel_data_start:
.section .kernel_stack,"aw",@progbits;
.align 2
kernel_stack_start:
.rept 4999
.4byte 0x0
.endr
kernel_stack_end:
.4byte 0x0
