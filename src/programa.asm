


section .data

    msgInicioProg               db      "Comienzo pruebas ....",10,0
    ;Mensajes Error

    mensajeErrorMenosVertices   db      "Error se requiere un Grafo de mas de 5 vertices",10,0
    mensajeErrorMasVertices     db      "Error se requiere un Grafo de menos de 15 vertices",10,0

    ;Datos Prueba primer Grafo

    cantidadVerticesPrueba1     db       4
    mensajePruebaUno            db      "Prueba 1: Grafo con 4 vertices da error.",0
    grafoPrueba1                dq       0

    ;Datos Prueba segundo grafo

    cantidadVerticesPrueba2     db       16
    mensajePruebaDos            db      "Prueba 2: Grafo con 16 vertices da error.",0
    grafoPrueba2                dq       0

    ;Datos Prueba tercer grafo

    grafoPrueba3                dq      0,16,13,0,0,0
                                dq      0,0,10,12,0,0
                                dq      0,4,0,0,14,0
                                dq      0,0,9,0,0,20
                                dq      0,0,0,7,0,4
                                dq      0,0,0,0,0,0
    
    cantidadVerticesPrueba3     db      6
    mensajePruebaTres           db      "Prueba 3: Grafo con 6 vertice, debe dar flujo igual a: 23",0


    flujoMaximo                 dq      0                                             ;Variable que almacena el flujo maximo 

;---Variables utilizadas en el BFS.  
    padreVertices               dq      -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
    verticesVisitados           dq      -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1  ;Inicio todos loc vertices como no visitados = -1 , visitados = 0
    contadorVerticesVisitados   dq      0
    punteroCola                 dq      0
    colaVerticesBfs             dq      -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1  ;INicio la cola con -1, significa que no hay datos.  
    contadorColaVertices        dq      0
    almacenamientoVerticesCOla  dq      0
    longitudELementos           dq      8
    contadorLoopBFS             dq      0
    filaActual                  dq      0
    columnaActual               dq      0
    formatNUm                   db      "padreVerticeFIN: %hi ",10,0
    Acatoy                      db     "acatoy",0


section .bss
    mensajePrueba               resb      100
    cantidadVertices            resb      1
    grafo                       resq      225
    verticeActual               resq      1
    pruebaDioError              resq      1

section .text
comienzoPrograma:
    sub         rsp,8
    
    
;   Mensaje de inicio programa  
    mov         rdi,msgInicioProg
    call        puts

;Almaceno datos Prueba 1 y la corro
    mov         rdi,mensajePruebaUno
    mov         rsi,[cantidadVerticesPrueba1]
    mov         rdx,[grafoPrueba1]
    call        inciarPrueba

;Almaceno datos Prueba 2 y la corro
    mov         rdi,mensajePruebaDos
    mov         rsi,[cantidadVerticesPrueba2]
    mov         rdx,[grafoPrueba2]
    call        inciarPrueba

;Almaceno datos Prueba 3 y la corro
    mov         rdi,mensajePruebaTres
    mov         rsi,[cantidadVerticesPrueba3]
    mov         rdx,[grafoPrueba3]
    call        inciarPrueba


;Fin Programa
finProg:
    add         rsp,8
    ret


;------------Rutinas Internas-------------------


inciarPrueba:
    ;ALmaceno datos recibidos de grafo.
    call        almacenarDatos
    ;Valido que el grafo sea correcto
    mov         qword[pruebaDioError],0
    call        validarGrafo

    cmp         qword[pruebaDioError],1
    je          finPrueba
    ;Busco un camino con bfs
    call        BFS


finPrueba:
    ret

;ALmaceno datos de las pruebas.
almacenarDatos:
    mov         [mensajePrueba],rdi
    mov         [cantidadVertices],rsi
    mov         [grafo],rdx
    ret


;Valido que el grafo sea correcto.
validarGrafo:
    mov         rdi,[mensajePrueba]
    call        puts

    cmp         byte[cantidadVertices],5
    jl          GrafoPocosVertices

    cmp         byte[cantidadVertices],15
    jg          grafoMuchosVertices

    ret


;Recorrido grafo con BFS


BFS:

;Agrego a la cola el vertice inicial
    mov         qword[colaVerticesBfs+0],0
    add         qword[contadorColaVertices],1

;Actualizo la variable para almacenar el prox elemento en el siguiente lugar.
    add         qword[almacenamientoVerticesCOla],8

;Marco el vertice inicial como visitado.
    mov         rdx,[contadorVerticesVisitados]
    mov         qword[verticesVisitados+rdx],0
    add         qword[contadorVerticesVisitados],1

inicioWhileBFS:

;Me fijo si hay elementos en la cola.
    cmp         qword[contadorColaVertices],0
    je          finBFS

;Saco de la cola el primer elemento.
    mov         rdi,[punteroCola]
    mov         rdi,[colaVerticesBfs+rdi]
    mov         qword[verticeActual],rdi

;Actualizo el puntero de la cola para apuntar a la siguiente posicion y resto el contador.
    add         qword[punteroCola],8
    sub         qword[contadorColaVertices],1
    mov         qword[contadorLoopBFS],0

inicioForBFS:
;Me fijo que el contadorDelLoop no sea igual que la cantidad de vertices.
    mov         rdi,qword[contadorLoopBFS]
    cmp         qword[cantidadVertices],rdi
    je          inicioWhileBFS

    imul        rdi,qword[longitudELementos]

;Me fijo si el vertice fue visitado, si fue sigo al siguiente.
    mov         rsi,qword[verticesVisitados+rdi]
    cmp         rsi,0
    je          siguienteVertice

;Me fijo si verticeActual esta conectado con el vertice.
    mov         rdi,[verticeActual]
    mov         qword[filaActual],rdi
    mov         rdi,[contadorLoopBFS]
    mov         qword[columnaActual],rdi
    call        desplazamientoMatriz

    ;Me fijo si tiene pase con el vertice.
    mov         rdi,[grafoPrueba3+rbx]
    cmp         rdi,0
    jle         siguienteVertice


;Marco como visitado al vertice
visitarVertice:

    mov         rdi,[contadorLoopBFS]
    imul        rdi,8

    mov         qword[verticesVisitados+rdi],0

;Agrego el vertice a la cola
agregarVerticeACola:

    mov         rdi,[almacenamientoVerticesCOla]
    mov         rsi,[contadorLoopBFS]
    mov         [colaVerticesBfs+rdi],rsi
    
    add         qword[almacenamientoVerticesCOla],8
    add         qword[contadorColaVertices],1


;Agrego el pagro
agregarPadre:
    mov         rdi,[verticeActual]
    mov         rsi,[contadorLoopBFS]
    imul        rsi,8
    mov         qword[padreVertices+rsi],rdi


;Agrego 1 al contador
siguienteVertice:
    add         qword[contadorLoopBFS],1
    jmp         inicioForBFS


;EL BFS termina
finBFS:
  
ret

desplazamientoMatriz:
    mov         rax,qword[filaActual]
    imul        rax,qword[longitudELementos]
    imul        rax,qword[cantidadVertices]

    mov         rbx,rax

    mov         rax,qword[columnaActual]
    imul        rax,qword[longitudELementos]

    add         rbx,rax
ret
;------------Mensajes Error--------------------


GrafoPocosVertices:
    mov         rdi,mensajeErrorMenosVertices
    call        puts
    mov        qword[pruebaDioError],1
    ret

grafoMuchosVertices:
    mov         rdi,mensajeErrorMasVertices
    call        puts
    mov         qword[pruebaDioError],1
    ret
