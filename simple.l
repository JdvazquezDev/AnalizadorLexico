%{
#include <stdio.h>
#include <stdlib.h>
int linea = 1;
%}

LINEA   \n

%%

{LINEA} linea++;

[#][#][\sAa-zZ] ;

[ \t] ;


(?i:abstracto)    |
(?i:booleano)   |
(?i:bucle)    |
(?i:caracter)   |
(?i:casos)    |
(?i:clase)    |
(?i:como)   |
(?i:constante)    |
(?i:constructor)  |
(?i:corto)    |
(?i:cuando) |
(?i:de)   |
(?i:descendente)      |
(?i:destructor)   |
(?i:devolver)   |
(?i:diccionario)    |
(?i:en)     |
(?i:entero)   |
(?i:entonces)   |
(?i:enumeracion)    |
(?i:es)     |
(?i:especifico)   |
(?i:excepcion)    |
(?i:exportar)   |
(?i:falso)    |
(?i:fin)    |
(?i:final)    |
(?i:finalmente)   |
(?i:generico)   |
(?i:importar)   |
(?i:largo)    |
(?i:lanza)    |
(?i:libreria)   |
(?i:lista)    |
(?i:mientras)   |
(?i:objeto) |
(?i:otro)   |
(?i:para)   |
(?i:principio)    |
(?i:privado)    |
(?i:programa)   |
(?i:protegido)  |
(?i:prueba)   |
(?i:publico)    |
(?i:rango)    |
(?i:real)   |
(?i:referencia)   |
(?i:registro)   |
(?i:repetir)    |
(?i:salir)    |
(?i:si)     |
(?i:signo)    | 
(?i:siguiente)    |
(?i:sino)   |
(?i:subprograma)    |
(?i:tabla)    |
(?i:tipo)   |
(?i:ultima)   |
(?i:valor)    |
(?i:verdadero)   printf("linea %d, palabra reservada: %s\n", linea,yytext);
[a-zA-Z_]{1}[a-zA-Z0-9_]* printf("linea %d, identificador: %s\n", linea, yytext);
.    printf("ERROR en la línea: %d, caracter %s no reconocido\n", linea, yytext);
%%

int yywrap() {
  return(1);
}

int main(int argc, char *argv[]) {

  if (argc < 2) {
    printf("Uso: ./simple NombreArchivo\n");
    }
  else {

    yyin = fopen(argv[1],"r");
    yylex();
    fclose(yyin);

    }
  }
