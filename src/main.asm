;************************************************************************
;                    Trabajo Organizacion del Computador                *
;                                                                       *
;Nombre: Juan Ignacio Colombo                                           *
;Padron: 103471                                                         *
;Consigna: Halle un flujo de valor máximo y que muestre por pantalla    *
; cual fue el camino que se recorrió para obtener dicho flujo           *                                                        
;************************************************************************

global main

;-------------------Importo archivos externos
%include               "presentacion.asm"            ;archivo inicio programa
%include               "creditos.asm"  
%include               "programa.asm"


;-------------------Importo funciones de C
extern puts
extern printf
extern gets
extern sscanf
extern fopen
extern fread
extern fclose
extern fgets

;-----------------------------------------------------------

section .text

main:

    ;LLamo a inicioPrograma para imprimir presentacion.
    call        inicioTp



                ret
