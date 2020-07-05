
section .data
    mensajeInicio           db      `-----Calculo de red de flujo maximo-----\n`,0     ;Mensaje que muestra titulo inicio.
    mensajeInstrucciones    db      `Ingrese uno de los siguientes numeros para continuar: \n`,10,0    ;Mensaje opciones
    mensajeComienzoProg     db      "Presione 1 para comenzar programa.",10,0
    mensajeCreditos         db      "Presione 2 para mostrar los creditos.",10,0
    mensajeIntro            db      "Presione 3 para ver introduccion al trabajo.",10,0
    mensajeExit             db      `Presione 4 para finalizar.\n`,10,0
    mensajeInput            db      "Input: ",0
    mensajeMaxIntentos      db       "Alcanzo los intentos maximos.",10,0
    limpiarTrm              db       27,"[H",27,"[2J",0    ; <ESC> [H <ESC> [2J
    archivoInfoTeorica      db      "introTeorica.txt",0
    modoApertura            db      "r",0
    mensajeError            db      "Error al abrir el archivo",0
;---------------------------------------------------------------------------------------------------------------------
section .bss
    numeroIngresado     resb    100
    fileHandle          resq    1
    archivoInfo         resq    1
    registroInfo        resb    100  

;---------------------------------------------------------------------------------------------------------------------

section .text
impresion:
    

;------Impresion por pantalla inicio tp.---------
    mov         rdi,mensajeInicio 
    call        puts

;------Impresiones opciones inicio trabajo------
opcionesComienzoTp:
  
    mov         rdi,mensajeInstrucciones
    call        printf

    mov         rdi,mensajeComienzoProg
    call        printf

    mov         rdi,mensajeCreditos
    call        printf

    mov         rdi,mensajeIntro
    call        printf

    mov         rdi,mensajeExit
    call        printf

    mov         rdi,mensajeInput
    call        printf

    mov         rdi,numeroIngresado
    call        gets


;--------Comparo input para ver instruccion
    cmp         byte[numeroIngresado],"1"
    je          inicioPrograma

    cmp         byte[numeroIngresado],"2"
    je          creditos

    cmp         byte[numeroIngresado],"3"
    je          introTeorica

    cmp         byte[numeroIngresado],"4"
    je          finPrograma
;--------Se fija si el programa debe continuar

    cmp         byte[numeroIngresado],"n"
    je          limpiarTerminal
    call        finPrograma

                                            ret
;---------Funcion que limpia contenido terminal.
limpiarTerminal:
    mov         rdi,limpiarTrm
    call        printf
    jmp         opcionesComienzoTp
                                            ret
    
inicioPrograma:
    mov         byte[numeroIngresado],"n"
    call        comienzoPrograma
                                            ret
introTeorica:
    mov         byte[numeroIngresado],"n"
    mov         rdi,archivoInfoTeorica
    mov         rsi,modoApertura
    call        fopen

    cmp         rax,0
    jle         errorArchivo

    mov         qword[fileHandle],rax

    call        lecturaArchivo
    ret
                                            
creditos:
    mov         byte[numeroIngresado],"n"
    call        creditosTp
    call        finPrograma
                
                                            ret

lecturaArchivo:
    mov         rdi,registroInfo
    mov         rsi,140
    mov         rdx,[fileHandle]
    call        fgets

    cmp         rax,0
    jle         EOF

    mov         rdi,registroInfo
    call        puts
    jmp         lecturaArchivo

errorArchivo:
    mov         rdi,errorArchivo
    call        printf

EOF:
    mov         rdi,[fileHandle]
    call        fclose   

finPrograma:
   
                                            ret
