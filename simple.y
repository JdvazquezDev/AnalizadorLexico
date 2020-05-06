 
%{

  #include <stdio.h>
  extern FILE *yyin;
  extern int yylex();

  #define YYDEBUG 1

%}

%token ABSTRACTO BOOLEANO BUCLE CARACTER CASOS CLASE COMO CONSTANTE CONSTRUCTOR CORTO
%token CUANDO DE DESCENDENTE DESTRUCTOR DEVOLVER DICCIONARIO EN ENTERO ENTONCES 
%token ENUMERACION ES ESPECIFICO EXCEPCION EXPORTAR FALSO FIN FINAL FINALMENTE GENERICO
%token IMPORTAR LARGO LANZA LIBRERIA LISTA MIENTRAS OBJETO OTRO PARA PRINCIPIO PRIVADO
%token PROGRAMA PROTEGIDO PRUEBA PUBLICO RANGO REAL REFERENCIA REGISTRO REPETIR SALIR
%token SI SIGNO SIGUIENTE SINO SUBPROGRAMA TABLA TIPO ULTIMA VALOR VERDADERO CTC_CARACTER
%token CTC_CADENA IDENTIFICADOR CTC_ENTERA CTC_REAL DOS_PUNTOS CUATRO_PUNTOS
%token ASIGNACION FLECHA INC DEC DESPI DESPD LEQ GEQ NEQ AND OR ASIG_SUMA ASIG_RESTA
%token ASIG_MULT ASIG_DIV ASIG_RESTO ASIG_POT ASIG_DESPI ASIG_DESPD

%%


/*****************/
/* instrucciones */
/*****************/

bloque_instrucciones
: instruccion { printf(" bloques_instrucciones -> instruccion\n"); }
| bloque_instrucciones instruccion  { printf(" bloques_instrucciones -> bloques_instrucciones instruccion\n"); }
;

instruccion
	:';'	{ printf ("  instruccion -> ';'\n"); }
	|instruccion_asignacion  { printf ("  instruccion -> instruccion_asignacion\n"); }
	|instruccion_devolver	{ printf ("  instruccion -> instruccion_devolver\n"); }
	|instruccion_llamada	{ printf ("  instruccion -> instruccion_llamada\n"); }
	|instruccion_si		{ printf ("  instruccion -> instruccion_si\n"); }
	|instruccion_casos	{ printf ("  instruccion -> instruccion_casos\n"); }
	|instruccion_bucle	{ printf ("  instruccion -> instruccion_bucle\n"); }
	|instruccion_interrupcion	{ printf ("  instruccion -> instruccion_interrupcion\n"); }
	|instruccion_lanzamiento_excepcion	{ printf ("  instruccion -> instruccion_lanzamiento_excepcion\n"); }
  |instruccion_captura_excepcion	{ printf ("  instruccion -> instruccion_captura_excepcion\n"); }
	|error ';' {yyerrok;}
	;

instruccion_asignacion
	:objeto op_asignacion expresion ';'	{ printf ("  instruccion_asignacion -> objeto op_asignacion expresion ';'\n"); }
	;

  op_asignacion
	:ASIG { printf ("  op_asignacion -> ASIGNACION\n"); }
	| SUMA_ASIG { printf ("  op_asignacion -> ASIG_SUMA\n"); }
	| RESTA_ASIG { printf ("  op_asignacion -> ASIG_RESTA_n"); }
	| MULT_ASIG { printf ("  op_asignacion -> ASIG_MULTn"); }
	| DIV_ASIG { printf ("  op_asignacion -> ASIG_DIV\n"); }
	| ASIG_POT { printf ("  op_asignacion -> ASIG_POT\n"); }
	| ASIG_RESTO { printf ("  op_asignacion -> ASIG_RESTO\n"); }
 	| ASIG_DESPI { printf ("  op_asignacion -> ASIG_DESPI\n"); }
	| ASIG_DESPD { printf ("  op_asignacion -> ASIG_DESPD\n"); }
;

instruccion_devolver
	: DEVOLVER	';' { printf ("  instruccion_devolver -> DEVOLVER ’;’ \n"); }
  |  DEVOLVER [ expresion ] ’;’ { printf ("  instruccion_devolver -> DEVOLVER [ expresion ]’;’ \n"); }
	;

instruccion_llamada
	: llamada_subprograma ';'	{ printf ("  instruccion_llamada -> llamada_subprograma\n"); }
	;

llamada_subprograma
  : nombre '(' ')' { printf(" llamada_subprograma -> nombre '('  ')' \n"); }
  | nombre '(' definicion_parametros ')' { printf(" llamada_subprograma -> nombre '(' definicion_parametros ')' \n"); }
  ;

instruccion_si 
  : SI expresion ENTONCES bloque_instrucciones FIN SI { printf(" instruccion_si -> SI expresion ENTONCES bloque_instrucciones FIN SI \n"); }
  | SI expresion ENTONCES bloque_instrucciones SINO bloque_instrucciones FIN SI { printf(" instruccion_si ->  SI expresion ENTONCES bloque_instrucciones SINO bloque_instrucciones FIN SI \n"); }
  ;

instruccion_casos
	: CASOS expresion ES casos FIN CASOS ';'	{ printf ("  instruccion_casos -> CASOS expresion ES casos + FIN CASOS';' \n"); }	
	;

casos
  : caso { printf(" casos -> caso \n"); }
  | casos caso { printf(" casos -> casos caso \n"); }
  ;

caso
	: CUANDO entradas ’=>’ bloque_instrucciones	{ printf ("  caso ->CUANDO entradas ’=>’ bloque_instrucciones \n"); }	
	;

entradas 
  : entrada { printf(" entradas -> entrada \n"); }
  | entradas ':' entrada { printf(" entradas -> entradas ':' entrada \n"); }
  ;

entrada
  : expresion { printf(" entrada -> expresion \n"); }
  | expresion [.. expresion] { printf(" entrada -> expresion ['..'  expresion]\n"); }
  | OTRO
  ;

instruccion_bucle
	:  clausula_iteracion bloque_instrucciones FIN BUCLE { printf(" instruccion_bucle -> clausula_iteracion bloque_instrucciones FIN BUCLE \n"); }
  | [ IDENTIFICADOR ':' ] clausula_iteracion bloque_instrucciones FIN BUCLE	{ printf ("  instruccion_bucle -> [ IDENTIFICADOR ’:’ ] clausula_iteracion bloque_instrucciones FIN BUCLE \n"); }
	;

clausula_iteracion
  :	PARA IDENTIFICADOR EN expresion { printf ("  clausula_iteracion -> PARA IDENTIFICADOR EN expresion  \n"); }
  | PARA IDENTIFICADOR [ ’:’ especificacion_tipo ] EN expresion { printf ("  clausula_iteracion -> PARA IDENTIFICADOR EN  [ ’:’ especificacion_tipo ]  expresion  \n"); }
  | REPETIR IDENTIFICADOR EN rango { printf ("  clausula_iteracion ->REPETIR IDENTIFICADOR EN rango \n"); }
  | REPETIR IDENTIFICADOR [ ’:’ especificacion_tipo ] EN rango { printf ("  clausula_iteracion ->REPETIR IDENTIFICADOR [ ’:’ especificacion_tipo ] EN rango \n"); }
  | REPETIR IDENTIFICADOR EN rango [ DESCENDENTE ] { printf ("  clausula_iteracion ->REPETIR IDENTIFICADOR EN rango [ DESCENDENTE ] \n"); }
  | REPETIR IDENTIFICADOR [ ’:’ especificacion_tipo ] EN rango [ DESCENDENTE ] { printf ("  clausula_iteracion ->REPETIR IDENTIFICADOR [ ’:’ especificacion_tipo ] EN rango [ DESCENDENTE ] \n"); }
  | MIENTRAS expresion { printf ("  clausula_iteracion -> MIENTRAS expresion  \n"); }
	| error ';' {yyerrok;}
	;

instruccion_interrupcion 
  : SIGUIENTE ';' { printf(" instruccion_interrupcion -> SIGUIENTE ';' \n"); }
  | SIGUIENTE cuando ';' { printf(" instruccion_interrupcion -> SIGUIENTE cuando ';' \n"); }
  | SALIR ';' { printf(" instruccion_interrupcion -> SALIR ';'\n"); }
  | SALIR DE IDENTIFICADOR ';' { printf(" instruccion_interrupcion -> SALIR DE IDENTIFICADOR ';' \n"); }
  | SALIR cuando ';' { printf(" instruccion_interrupcion -> SALIR cuando ';' \n"); }
  | SALIR DE IDENTIFICADOR cuando ';' { printf(" instruccion_interrupcion -> SALIR DE IDENTIFICADOR cuando ';' \n"); }
  ;


instruccion_lanzamiento_excepcion
: LANZA nombre ’;’ {printf (" instruccion_lanzamiento_excepcion ->  LANZA nombre\n"); }


instruccion_captura_excepcion
: PRUEBA bloque_instrucciones clausulas FIN PRUEBA  {printf (" instruccion_captura_excepcion ->  PRUEBA bloque_instrucciones clausulas FIN PRUEBA\n"); }

clausulas
  : clausulas_excepcion {printf (" clausulas -> clausulas_excepcion \n"); }
  | clausulas [ clausula_finalmente ] {printf (" clausulas -> clausulas_excepcion \n"); }
  | clausula_finalmente {printf (" clausulas ->  clausula_finalmente\n"); }

clausulas_excepcion
	:  clausula_excepcion_general	{ printf ("  clausulas_excepcion -> clausula_excepcion_general\n"); }
  | [clausula_excepcion_especifica] clausula_excepcion_general	{ printf ("  clausulas_excepcion -> [clausula_excepcion_especifica] clausula_excepcion_general\n"); }
	| error ';' {yyerrok;}
	;

clausula_excepcion_especifica
	: EXCEPCION ’(’ nombre ’)’ bloque_instrucciones	{ printf ("  clausula_excepcion -> EXCEPCION ’(’ nombre ’)’ bloque_instrucciones\n"); }
	;

clausula_excepcion_general 
: EXCEPCION bloque_instrucciones { printf ("  clausula_excepcion -> EXCEPCION bloque_instrucciones\n"); }

clausula_finalmente
: FINALMENTE bloque_instrucciones {printf (" clausula_finalmente ->  FINALMENTE bloque_instrucciones"); }



%%

int yyerror(char *s) {
  fflush(stdout);
  printf("***************** %s\n",s);
  }

int yywrap() {
  return(1);
  }

int main(int argc, char *argv[]) {

  yydebug = 0;

  if (argc < 2) {
    printf("Uso: ./simple NombreArchivo\n");
    }
  else {
    yyin = fopen(argv[1],"r");
    yyparse();
    }
  }
