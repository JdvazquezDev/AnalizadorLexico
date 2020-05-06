%{
#include <stdio.h>
#include <stdlib.h>
int linea = 1;
%}


PALABRAS_RESERVADAS   (?i:abstracto)|(?i:booleano)|(?i:bucle)|(?i:caracter)|(?i:casos)|(?i:clase)|(?i:como)|(?i:constante)|(?i:constructor)|(?i:corto)|(?i:cuando)|(?i:de)|(?i:descendente)|(?i:destructor)|(?i:devolver)|(?i:diccionario)|(?i:en)|(?i:entero)|(?i:entonces)|(?i:enumeracion)|(?i:es)|(?i:especifico)|(?i:excepcion)|(?i:exportar)|(?i:falso)|(?i:fin)|(?i:final)|(?i:finalmente)|(?i:generico)|(?i:importar)|(?i:largo)|(?i:lanza)|(?i:libreria)|(?i:lista)|(?i:mientras)|(?i:objeto)|(?i:otro)|(?i:para)|(?i:principio)|(?i:privado)|(?i:programa)|(?i:protegido)|(?i:prueba)|(?i:publico)|(?i:rango)|(?i:real)|(?i:referencia)|(?i:registro)|(?i:repetir)|(?i:salir)|(?i:si)|(?i:signo)|(?i:siguiente)|(?i:sino)|(?i:subprograma)|(?i:tabla)|(?i:tipo)|(?i:ultima)|(?i:valor)|(?i:verdadero)
IDENTIFICADOR         [a-zA-Z_][a-zA-Z0-9_]*
CONSTANTE_ENTERA      [0-9]+|[%][xX][0-9a-fA-F]+|[%][oO][0-7]+
CONSTANTE_REAL        [0-9]*["."]?[0-9]+["^"]?[+-]?[0-9]+|[%][xX][0-9a-fA-F]*["."]?[0-9a-fA-F]+["^"]?[+-]?[0-9a-fA-F]+|[%][oO][0-7]*["."]?[0-7]+["^"]?[+-]?[0-7]+
CARACTER              [^\n'%\"]|"%'"|"%\""|"%%"|"%n"|"%r"|"%t"|(%[0-2]?[0-9]{1,2})|(%[oO][0-3]?[0-7]{0,2})|(%[xX][0-9a-fA-F]{1,2})
CADENA                \"({CARACTER})*[^\"]*({CARACTER})*\"
DELIMITADOR            \(|\)|\:|\;|\,|\||\=>|\¨|".."
OPERADOR              \+|\-|\*|\/|\-\-|\+\+|\\|\^|\<\-|\-\>|\:=|\:\+|\:\-|\:\/|\:\\|\:\^|\:\<|\:\>|\.|\[|\]|\{|\}|\:\:|\<|\>|\<\=|\>\=|\=|\/\\|\\\/
COMENTARIO            [#][#].+|[#][{].*[\n]*.*[#][}] 
LINEA   \n


%%


[ \t] ;
{LINEA} linea++;
{PALABRAS_RESERVADAS}    printf("linea %d, palabra reservada: %s\n", linea,yytext);
{IDENTIFICADOR}          printf("linea %d, identificador: %s\n", linea, yytext);
{CONSTANTE_ENTERA}       printf("linea %d, ctc entera: %s\n", linea,yytext);
{CONSTANTE_REAL}         printf("linea %d, ctc real: %s\n", linea,yytext);
{DELIMITADOR}            printf("linea %d, delimitador: %s\n", linea,yytext);

":="                       { printf("linea %d, operador %s\n", linea, yytext); return (ASIG); }
":+"                       { printf("linea %d, operador %s\n", linea, yytext); return (SUM_ASIG); }
":-"                       { printf("linea %d, operador %s\n", linea, yytext); return (RES_ASIG); }
":/"                       { printf("linea %d, operador %s\n", linea, yytext); return (DIV_ASIG); }
":\\"                       { printf("linea %d, operador %s\n", linea, yytext); return (MOD_ASIG); }
":^"                       { printf("linea %d, operador %s\n", linea, yytext); return (POT_ASIG); }
":<"                       { printf("linea %d, operador %s\n", linea, yytext); return (DIZQ_ASIG); }
":>"                       { printf("linea %d, operador %s\n", linea, yytext); return (DDER_ASIG); }


{CARACTER}               printf("linea %d, caracter: %s\n", linea,yytext);
{CADENA}                 printf("linea %d, cadena: %s\n", linea,yytext);
{COMENTARIO}             ;
.                        printf("ERROR en la línea: %d, caracter %s no reconocido\n", linea, yytext);


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
