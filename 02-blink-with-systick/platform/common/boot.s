.cpu cortex-m0
.thumb

.word   _stack_base
.word   main
.word   hang
.word   hang
.word   hang
.word   hang
.word   hang
.word   _boot_checksum
.word   hang
.word   hang
.word   hang
.word   hang
.word   hang
.word   hang
.word   hang
.word   hang
.word   hang


.thumb_func
hang:   b .

.global hang
