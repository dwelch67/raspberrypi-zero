
;@-------------------------------------------------------------------
;@-------------------------------------------------------------------

.globl _start
_start:
    ldr pc,reset_handler
    ldr pc,undefined_handler
    ldr pc,swi_handler
    ldr pc,prefetch_handler
    ldr pc,data_handler
    ldr pc,unused_handler
    ldr pc,irq_handler
    ldr pc,fiq_handler
reset_handler:      .word reset
undefined_handler:  .word hang
swi_handler:        .word doswi
prefetch_handler:   .word hang
data_handler:       .word hang
unused_handler:     .word hang
irq_handler:        .word hang
fiq_handler:        .word hang

.type reset,%function
reset:
    mov r0,#0x8000
    mov r1,#0x0000
    ldmia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}
    stmia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}
    ldmia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}
    stmia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}
	mov sp,#0x8000
	bl notmain
	b hang
.type hang,%function
hang: b hang


.type PUT32,%function
.globl PUT32
PUT32:
    str r1,[r0]
    bx lr

.type GET32,%function
.globl GET32
GET32:
    ldr r0,[r0]
    bx lr

.type myswicall,%function
.globl myswicall
myswicall:
	push {r3,lr}
	swi 0
	pop {r3,lr}
	bx lr

.code 32
.type doswi,%function
doswi:
	push {r3,lr}
	bl my_swi_handler
	pop {r3,lr}
	movs pc,lr



;@-------------------------------------------------------------------
;@-------------------------------------------------------------------

;@-------------------------------------------------------------------
;@
;@ Copyright (c) 2012 David Welch dwelch@dwelch.com
;@
;@ Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
;@
;@ The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
;@
;@ THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
;@
;@-------------------------------------------------------------------
