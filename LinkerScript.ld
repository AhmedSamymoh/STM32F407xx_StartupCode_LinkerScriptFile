/*
 * @file     Linkerscript.ld
 * @date     Aug 10, 2023
 * @author   Ahmed Samy
 * @link     https://github.com/AhmedSamymoh
 *
 * @brief    This file contains The linkerscript of STM32f407xx.
*/


/*
* Linker Script Symbols
* _edata : End of data section
* _sbss : Start of bss section
* _ebss : End of bss section
* _sidata : Start of data section
*/

/* End of "RAM" Ram type memory */
_estack = ORIGIN(RAM) + LENGTH(RAM); 



_Min_Heap_Size = 0x200;  /* Minimum heap size */
_Min_Stack_Size = 0x400; /* Minimum stack size */ 


/* Memories Definitions 
* Label_Name(AttributeList) : ORIGIN = StartMemoryAddress,   LENGTH = MemoryLength
*/
MEMORY{
    RAM    (xrw) : ORIGIN = 0x20000000, LENGTH = 128K
    FLASH  (xrw) : ORIGIN = 0x08000000, LENGTH = 1024K
    CCMRAM (xrw) : ORIGIN = 0x10000000, LENGTH = 64K
}

SECTIONS{
  /* The startup code into "FLASH" Rom type memory */
  .isr_vector :
  {
    . = ALIGN(4);
    *(.isr_vector)
    . = ALIGN(4);
  } >FLASH

  /* .text section, The program code and other data into "FLASH" Rom type memory */
  .text :
  {
    . = ALIGN(4);
    *(.text)           /* .text sections (code) */
    *(.text*)          /* .text* sections (code) */
    . = ALIGN(4);
    _etext = .;        /* Define a global symbols at end of code */
  } >FLASH

  /* .rodata section, Constant data into "FLASH" Rom type memory */
  .rodata :
  {
    . = ALIGN(4);
    *(.rodata)         /* .rodata sections (constants, strings, etc.) */
    *(.rodata*)        /* .rodata* sections (constants, strings, etc.) */
    . = ALIGN(4);
    _erodata = .;      /* Define a global symbol at end of data */
  } >FLASH

  Used by the startup to initialize data
  _sidata = LOADADDR(.data);

  /* .data section, Initialized data sections into "RAM" Ram type memory */
  .data :
  {
    . = ALIGN(4);
    _sdata = .;        /* Create a global symbol at data start */
    *(.data)           /* .data sections */
    *(.data*)          /* .data* sections */
    . = ALIGN(4);
    _edata = .;        /* Define a global symbol at data end */
  } >RAM AT> FLASH

  /* .bss section, Uninitialized data section into "RAM" Ram type memory */
   . = ALIGN(4);
  .bss :
  {
    _sbss = .;         /* Define a global symbol at bss start */
    *(.bss)            /* .bss sections */
    *(.bss*)           /* .bss* sections */
    . = ALIGN(4);
    _ebss = .;         /* Define a global symbol at bss end */
  } >RAM

  /* .User_heap_stack section, used to check that there is enough "RAM" Ram  type memory left */
  ._user_heap_stack :
  {
    . = ALIGN(8);
    . = . + _Min_Heap_Size;
    . = . + _Min_Stack_Size;
    . = ALIGN(8);
  } >RAM
}
