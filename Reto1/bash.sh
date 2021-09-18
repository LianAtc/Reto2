nasm -f elf64 -g Funcion.asm -o Funcion.o
ld Funcion.o -o Funcion #Ejecutable
gdb -x depurando.gdb
./Funcion