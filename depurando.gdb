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

echo fijar un breakpoint en comienzo
b _start
r
echo ¿Donde estamos?
disassemble 
echo Verificamos que las variables pasaron su valor correctamente
ni 2
echo Las guardamos en los registros siguientes
i r rbx
i r rcx

echo Saltamos a las operaciones 
b vuelta
c 
ni 4
echo Vemos como van operando nuestros registros

echo r9 = N
i r r9
echo rax = a * rax, es el a^(n+1)
i r rax  

ni 4

disassemble
echo Vemos como se va calculando correctamente a^(n+1)
i r rax

echo Verificamos las otras funciones viendo todos los registros
i r

ni 7
disassemble
echo a^(n+1)
i r rax 

ni 2
echo Verificamos el resultado
echo TERMINO DERECHO
i r r10

echo Pasamos a la sumatoria de la izquierda

b suma
c 
b continuo_suma
c 
i r r15
echo Verificamos que i avance correctamente
i r r14
ni 4 
echo Verificamos que i avance correctamente
i r r14

echo Verificamos que a^i se halle corectamente
i r rax
echo Vemos si se estan sumando bien los a^i
i r r15

echo Verificacion general de todos los registros
i r

b exit
c 
echo Una vez estamos al final revisamos la respuesta

echo Verificamos el resultado
echo TERMINO IZQUIERDO
i r r15

q 