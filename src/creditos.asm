
section .data
    mensajeAlumno       db      "Trabajo Practico Organizacion del computador",0
    mensajeNombre       db      "Realizado por Juan Ignacio Colombo",0
    padron              db      "Padron:    103471",0
    fecha               db      "Fecha:     1C-2020",0
    limpiar      db       27,"[H",27,"[2J",0    ; <ESC> [H <ESC> [2J

   
section .text

creditosTp:
  
    mov     rdi,limpiar
    call    puts
    
    mov     rdi,mensajeAlumno
    call    puts

    mov     rdi,mensajeNombre
    call    puts

    mov     rdi,padron
    call    puts

    mov     rdi,fecha
    call    puts
                                ret
