main:	main.o
			gcc -o main.out main.o -no-pie 

main.o:	main.asm
				
				nasm -f elf64 -g -F stabs main.asm


clean:
	rm *.o  *.out 
