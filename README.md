# FlujoMaximoRed


Consigna:

Dada una red con N vértices (con 5<= N <=15), pesado y dirigido, desarrollar un programa en assembler Intel
80x86 que obtenga el flujo maximal de la misma o lo que es lo mismo, que halle un flujo de valor
máximo y que muestre por pantalla cual fue el camino que se recorrió para obtener dicho flujo.

Solucion:

 El siguiente problema se resolvio aplicando el algoritmo de Ford-Fulkerson para grafos.
 El siguiente consiste en recorrer el grafo con un recorrido BFS, y asi hallar los posibles caminos, en caso de no encontrar un camino, significa que ya no puede fluir mas flujo mediante los vertices, con lo cual se llego al flujo maximo.
 
 
 Como correr el programa:
 
 1- Moverse al directorio donde se tienen los archivos descargados.
 
 2- make (para ensamblar y compilar).
 
 3- ./main.out para correr el programa.
 
 4- Para borrar los ejecutables correr make clean.
