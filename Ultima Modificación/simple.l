%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "simple.tab.h"
int linea = 1;
%}



PALABRAS_RESERVADAS   (?i:abstracto)|(?i:booleano)|(?i:bucle)|(?i:caracter)|(?i:casos)|(?i:clase)|(?i:como)|(?i:constante)|(?i:constructor)|(?i:corto)|(?i:cuando)|(?i:de)|(?i:descendente)|(?i:destructor)|(?i:devolver)|(?i:diccionario)|(?i:en)|(?i:entero)|(?i:entonces)|(?i:enumeracion)|(?i:es)|(?i:especifico)|(?i:excepcion)|(?i:exportar)|(?i:falso)|(?i:fin)|(?i:final)|(?i:finalmente)|(?i:generico)|(?i:importar)|(?i:largo)|(?i:lanza)|(?i:libreria)|(?i:lista)|(?i:mientras)|(?i:objeto)|(?i:otro)|(?i:para)|(?i:principio)|(?i:privado)|(?i:programa)|(?i:protegido)|(?i:prueba)|(?i:publico)|(?i:rango)|(?i:real)|(?i:referencia)|(?i:registro)|(?i:repetir)|(?i:salir)|(?i:si)|(?i:signo)|(?i:siguiente)|(?i:sino)|(?i:subprograma)|(?i:tabla)|(?i:tipo)|(?i:ultima)|(?i:valor)|(?i:verdadero)
IDENTIFICADOR         [a-zA-Z_][a-zA-Z0-9_]*
CONSTANTE_ENTERA      [0-9]+|[%][xX][0-9a-fA-F]+|[%][oO][0-7]+
CONSTANTE_REAL        [0-9]*["."]?[0-9]+["^"]?[+-]?[0-9]+|[%][xX][0-9a-fA-F]*["."]?[0-9a-fA-F]+["^"]?[+-]?[0-9a-fA-F]+|[%][oO][0-7]*["."]?[0-7]+["^"]?[+-]?[0-7]+
CARACTER              [^\n'%\"]|"%'"|"%\""|"%%"|"%n"|"%r"|"%t"|(%[0-2]?[0-9]{1,2})|(%[oO][0-3]?[0-7]{0,2})|(%[xX][0-9a-fA-F]{1,2})
CADENA                \"({CARACTER})*[^\"]*({CARACTER})*\"
DELIMITADOR            \(|\)|\:|\;|\,|\||\=>|\¨|".."
OPERADOR              \+|\-|\*|\/|\-\-|\+\+|\\|\^|\<\-|\-\>|\.|\[|\]|\{|\}|\:\:|\<|\>|\<\=|\>\=|\=|\/\\|\\\/|~=|~
COMENTARIO            [#][#].+|[#][{].*[\n]*.*[#][}] 
LINEA   \n


%%


[ \t] ;
{LINEA} linea++;

(?i:abstracto) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (ABSTRACTO);}
(?i:booleano)  {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (BOOLEANO);}
(?i:bucle)     {printf("linea %d, palabra reservada: %s\n",linea,yytext);return(BUCLE);}
(?i:caracter)  {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (CARACTER);}
(?i:casos)     {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (CASOS);}
(?i:clase)     {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (CLASE);}
(?i:como)      {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (COMO);}
(?i:constante) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (CONSTANTE);}
(?i:constructor)  {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (CONSTRUCTOR);}
(?i:corto)     {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (CORTO);}
(?i:cuando)    {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (CUANDO);}
(?i:de)        {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (DE);}
(?i:descendente)  {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (DESCENDENTE);}
(?i:destructor) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (DESTRUCTOR);}
(?i:devolver)  {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (DEVOLVER);}
(?i:diccionario)  {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (DICCIONARIO);}
(?i:en)        {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (EN);}
(?i:entero)    {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (ENTERO);}
(?i:entonces)  {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (ENTONCES);}
(?i:enumeracion)  {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (ENUMERACION);}
(?i:es)        {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (ES);}
(?i:especifico) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (ESPECIFICO);}
(?i:excepcion)  {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (EXCEPCION);}
(?i:exportar) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (EXPORTAR);}
(?i:falso) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (FALSO);}
(?i:fin) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (FIN);}
(?i:final) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (FINAL);}
(?i:finalmente) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (FINALMENTE);}
(?i:generico) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (GENERICO);}
(?i:importar) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (IMPORTAR);}
(?i:largo) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (LARGO);}
(?i:lanza) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (LANZA);}
(?i:libreria) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (LIBRERIA);}
(?i:lista) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (LISTA);}
(?i:mientras) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (MIENTRAS);}
(?i:objeto) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (OBJETO);}
(?i:otro) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (OTRO);}
(?i:para) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (PARA);}
(?i:principio) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (PRINCIPIO);}
(?i:privado) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (PRIVADO);}
(?i:programa) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (PROGRAMA);}
(?i:protegido) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (PROTEGIDO);}
(?i:publico) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (PUBLICO);}
(?i:prueba) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (PRUEBA);}
(?i:rango) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (RANGO);}
(?i:real) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (REAL);}
(?i:referencia) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (REFERENCIA);}
(?i:registro) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (REGISTRO);}
(?i:repetir) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (REPETIR);}
(?i:salir) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (SALIR);}
(?i:si) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (SI);}
(?i:signo) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (SIGNO);}
(?i:siguiente) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (SIGUIENTE);}
(?i:sino) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (SINO);}
(?i:subprograma) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (SUBPROGRAMA);}
(?i:tabla) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (TABLA);}
(?i:tipo) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (TIPO);}
(?i:ultima) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (ULTIMA);}
(?i:valor) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (VALOR);}
(?i:verdadero) {printf("linea %d, palabra reservada: %s\n",linea,yytext);return (VERDADERO);}


{IDENTIFICADOR}          {printf("linea %d, identificador: %s\n",linea,yytext);return (IDENTIFICADOR);}
{CONSTANTE_ENTERA}       {printf("linea %d, ctc entera: %s\n",linea,yytext);return (CTC_ENTERA);}
{CONSTANTE_REAL}         {printf("linea %d, ctc real: %s\n",linea,yytext);return (CTC_REAL);}



\(                 {printf("linea %d, delimitador: %s\n",linea,yytext);return (yytext[0]);}       
\)                 {printf("linea %d, delimitador: %s\n",linea,yytext);return (yytext[0]);}
":"                {printf("linea %d, delimitador: %s\n",linea,yytext);return (yytext[0]);}
";"                {printf("linea %d, delimitador: %s\n",linea,yytext);return (yytext[0]);}
","                {printf("linea %d, delimitador: %s\n",linea,yytext);return (yytext[0]);}

".."               {printf("linea %d, delimitador: %s\n",linea,yytext);return (DOS_PUNTOS);}

"|"                {printf("linea %d, delimitador: %s\n",linea,yytext);return (yytext[0]);}

"=>"               {printf("linea %d, delimitador: %s\n",linea,yytext);return(FLECHA);}

"+"                {printf("linea %d, operador %s\n",linea,yytext);return (yytext[0]);}
"*"                {printf("linea %d, operador %s\n",linea,yytext);return (yytext[0]);}
"^"                {printf("linea %d, operador %s\n",linea,yytext);return (yytext[0]);}
"-"                {printf("linea %d, operador %s\n",linea,yytext);return (yytext[0]);}
"/"                {printf("linea %d, delimitador: %s\n",linea,yytext);return (yytext[0]);}
"--"               {printf("linea %d, operador %s\n",linea,yytext);return (DEC);}
"++"               {printf("linea %d, operador %s\n",linea,yytext);return (INC);}
"\\"               {printf("linea %d, operador %s\n",linea,yytext);return(yytext[0]);}
"->"               {printf("linea %d, operador %s\n",linea,yytext);return(DESPD);}
"<-"               {printf("linea %d, operador %s\n",linea,yytext);return(DESPI);}
":="               {printf("linea %d, operador %s\n",linea,yytext);return(ASIGNACION);}
":+"               {printf("linea %d, operador %s\n",linea,yytext);return(ASIG_SUMA);}
":-"               {printf("linea %d, operador %s\n",linea,yytext);return(ASIG_RESTA);}
":*"               {printf("linea %d, operador %s\n",linea,yytext);return(ASIG_MULT);}
":/"               {printf("linea %d, operador %s\n",linea,yytext);return(ASIG_DIV);}
":\\"              {printf("linea %d, operador %s\n",linea,yytext);return (ASIG_RESTO);}
":^"               {printf("linea %d, operador %s\n",linea,yytext);return(ASIG_POT);}
":<"               {printf("linea %d, operador %s\n",linea,yytext);return(ASIG_DESPI);}
":>"               {printf("linea %d, operador %s\n",linea,yytext);return (ASIG_DESPD);}
"."                {printf("linea %d, operador %s\n",linea,yytext);return (yytext[0]);}
"["                {printf("linea %d, operador %s\n",linea,yytext);return (yytext[0]);}
"]"                {printf("linea %d, operador %s\n",linea,yytext);return (yytext[0]);}
"{"                {printf("linea %d, operador %s\n",linea,yytext);return (yytext[0]);}
"}"                {printf("linea %d, operador %s\n",linea,yytext);return (yytext[0]);}
"::"               {printf("linea %d, operador %s\n",linea,yytext);return (CUATRO_PUNTOS);}
"<"                {printf("linea %d, operador %s\n",linea,yytext);return (yytext[0]);}
">"                {printf("linea %d, operador %s\n",linea,yytext);return (yytext[0]);}
"<="               {printf("linea %d, operador %s\n",linea,yytext);return (LEQ);}
">="               {printf("linea %d, operador %s\n",linea,yytext);return (GEQ);}
"~="               {printf("linea %d, operador %s\n",linea,yytext);return (NEQ);}
"~"                {printf("linea %d, operador %s\n",linea,yytext);return (yytext[0]);}
"/\\"              {printf("linea %d, operador %s\n",linea,yytext);return (AND);}
"\\/"              {printf("linea %d, operador %s\n",linea,yytext);return (OR);}
"="                {printf("linea %d, operador %s\n",linea,yytext);return (yytext[0]);}



{CARACTER}              {printf("linea %d, caracter: %s\n",linea,yytext);return (CTC_CARACTER);}
{CADENA}                 {printf("linea %d, cadena: %s\n",linea,yytext);return (CTC_CADENA);}
{COMENTARIO}             ;
.                        printf("ERROR en la línea: %d, caracter %s no reconocido\n", linea, yytext);


%%
