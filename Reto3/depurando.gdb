# con esta sentencia se indica el archivo de salida 
# para poder ver los resultados
set logging file depuracion.txt

# para que las salidas de print se vean bien
set print pretty on

# para que las salidas de los comandos se registren
set logging on

# para evitar que gdb haga preguntas y\n
set pagination off

# fijar el argumento del programa
#set args

# indicar el archivo que se va a depurar
file Funcion

#aki
set disassembly-flavor intel

# hook previo para echo
define hook-echo
echo <<<---
end

# hook posterior para echo
define hookpost-echo
echo --->>>\n
end

echo fijar un breakpoint en main

b _start
r
b vuelta
c 

echo Verificamos que las direcciones se hayan pasado bien
i r rax
i r rbx

ni 3

echo Vemos que los caracteres se pasen bien
echo Palabra sin voltear
i r r9
echo Palabra volteada
i r r10

echo Si es que la palbra es igual o no revisamos las coincidencias
i r r11

b verificar 
c 

set $cont = $r12
printf "%d \n",$cont 
echo 
echo Mostramos 


while ($cont<$r15) 
   info r eax
   p $cont
   c
   #set $aux= $aux -1
   set $cont= $r12
end

echo Verificamos el valor de r15 que contiene la longitud de la cadena
i r r15
echo Verificamos las coincidencias
i r r11

echo Revision general de registros
i r

b exit
c

echo Mostramos lo que se guarda en la memoria
p (char) palindromo

q 