_stack_base = 0x10008000;
_boot_checksum = 0 - (_stack_base + main + 1 + isr_nmi + 1 + isr_hardfault + 1);

_data_load = LOADADDR(.data);

ENTRY(main)

MEMORY
{
    rom(RX)   : ORIGIN = 0x00000000, LENGTH = 0x80000
    ram(WAIL) : ORIGIN = 0x10000000, LENGTH = 0x8000
}

SECTIONS
{
    .text : ALIGN(4)
    {
        FILL(0xff)

        KEEP(*(.isr_vector))
        KEEP(*(.isr_vector_nvic))
    } > rom

    .text : ALIGN(4)
    {
        FILL(0xff)

        *(.text*)
        *(.rodata .rodata.*)
    } > rom

    .data : ALIGN(4)
    {
        _data = .;

        *(SORT_BY_ALIGNMENT(.data*))
        . = ALIGN(4);

        _edata = .;
    } > ram AT>rom = 0xff

    .bss : ALIGN(4)
    {
        _bss = .;

        *(.bss*)
        *(COMMON)
        . = ALIGN(4);

        _ebss = .;
    } > ram

    /DISCARD/ :
    {
        *(.glue_7*)  /* arm-thumb interworking */
        *(.v4_bx)  /* ARMv4 interworking fixup for missing BX */
        *(.vfp11_veneer)  /* VFP11 bugfixes s.a. http://sourceware.org/ml/binutils/2006-12/msg00196.html */
        *(.iplt .igot.plt)  /* STT_GNU_IFUNC symbols */
        *(.rel.*)  /* denamic relocations */
    }
}
