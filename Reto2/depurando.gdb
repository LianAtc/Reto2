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
echo ¿Donde estamos?
disassemble 
b resto 
c 

echo Verificamos que el numero se paso correctamente
i r rax


echo Verificamos como va operando, rdx contiene el resto
echo Al que ira calculando el factorial
i r rdx
echo Este se quedara con el cociente del numero
i r rax 

ni 3

echo Vemos como se va calculando el factorial
i r rax

echo Verificacion general
i r 


echo Vemos si el factorial de cada numero se suma correctamente
echo Suma de factoriales de cada digito
i r r9

echo Verificacion reasignacion de rax para que continue diviendo
i r rax 


set $cont = $rax
printf "%d \n",$cont 
echo 
echo Mostramos 


while ($cont>0) 
   #info r eax
   p $cont
   p $r9
   c
   #set $aux= $aux -1
   set $cont= $rax
end

b exit
c

echo Vemos la respuesta en r9
i r r9 

echo Vemos si se guardo en memoria T o F
p (char) fuerte

q 