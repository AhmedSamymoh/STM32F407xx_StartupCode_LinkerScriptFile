# STM32F407xx_StartupCode_LinkerScriptFile


```bash
# Compile the source files
arm-none-eabi-gcc -c Application.c -o Application.o
arm-none-eabi-gcc -c startup_stm32f407xx.c -o startup_stm32f407xx.o
```

```bash
# Link the object files
arm-none-eabi-ld -Map app.map -T LinkerScript.ld startup_stm32f407xx.o Application.o -o startup_stm32f407xx.elf
```