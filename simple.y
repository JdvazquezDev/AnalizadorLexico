 
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
	: ’devolver’ [ expresion ]? ’;’	{ printf ("  instruccion_devolver -> DEVOLVER expresion ';'\n"); }
	;

instruccion_llamada
	: llamada_subprograma ';'	{ printf ("  instruccion_llamada -> llamada_subprograma ';'\n"); }
	;

llamada_subprograma
	:nombre '(' ( definicion_parametro )* ')'	{ printf ("  llamada_subprograma -> nombre '(' ( definicion_parametro )* ')'\n"); }
	;

instruccion_si
	: ’si’ expresion ’entonces’ [ instruccion ]+ { printf ("  instruccion_si ->’si’ expresion ’entonces’ [ instruccion ]+ \n"); }	
	| ’si’ expresion ’entonces’ [ instruccion ]+ [ ’sino’ [ instruccion ]+ ]? ’fin’ ’si’	{ printf ("  instruccion_si -> ’si’ expresion ’entonces’ [ instruccion ]+ [ ’sino’ [ instruccion ]+ ]? ’fin’ ’si’ \n"); }
	;

instruccion_casos
	: ’casos’ expresion ’es’ [ caso ]+ ’fin’ ’casos’ ';'	{ printf ("  instruccion_casos -> ’casos’ expresion ’es’ [ caso ]+ ’fin’ ’casos’';' \n"); }	
	;

caso
	: ’cuando’ entradas ’=>’ [ instruccion ]+	{ printf ("  caso ->’cuando’ entradas ’=>’ [ instruccion ]+ \n"); }	
	;

entradas 
	:[ entrada ’:’ ]* entrada{ printf ("  entradas -> [ entrada ’:’ ]* entrada \n"); }
	;

entrada
	:expresion [ ’..’ expresion ]? | ’otro’	{ printf ("  entrada -> expresion [ ’..’ expresion ]? | ’otro’\n"); }
	;

instruccion_bucle
	: [ IDENTIFICADOR ’:’ ]? clausula_iteracion [ instruccion ]+ ’fin’ ’bucle’	{ printf ("  instruccion_bucle -> [ IDENTIFICADOR ’:’ ]? clausula_iteracion [ instruccion ]+ ’fin’ ’bucle’ \n"); }
	;

clausula_iteracion
	’para’ IDENTIFICADOR [ ’:’ especificacion_tipo ]? ’en’ expresion { printf ("  clausula_iteracion -> ’para’ IDENTIFICADOR [ ’:’ especificacion_tipo ]? ’en’ expresion  \n"); }
  | ’repetir’ IDENTIFICADOR [ ’:’ especificacion_tipo ]?’en’ rango [ ’descendente’ ]? { printf ("  clausula_iteracion ->’repetir’ IDENTIFICADOR [ ’:’ especificacion_tipo ]?’en’ rango [ ’descendente’ ]? \n"); }
  | ’mientras’ expresion { printf ("  clausula_iteracion -> mientras’ expresion  \n"); }
	|error ';' {yyerrok;}
	;

instruccion_interrupcion
	:’siguiente’ [ cuando ]? ’;’| ’salir’ [ ’de’ IDENTIFICADOR ]? [ cuando ]? ’;’{ printf ("  instruccion_interrupcion -> ’siguiente’ [ cuando ]? ’;’| ’salir’ [ ’de’ IDENTIFICADOR ]? [ cuando ]?  \n"); }
	;

instruccion_lanzamiento_excepcion
: ’lanza’ nombre ’;’ {printf (" instruccion_lanzamiento_excepcion ->  ’lanza’ nombre\n"); }


instruccion_captura_excepcion
: ’prueba’ [ instruccion ]+ clausulas ’fin’ ’prueba’  {printf (" instruccion_captura_excepcion ->  ’prueba’ [ instruccion ]+ clausulas ’fin’ ’prueba’\n"); }

clausulas
:clausulas_excepcion [ clausula_finalmente ]? {printf (" clausulas ->  clausulas_excepcion [ clausula_finalmente ]?\n"); }
| clausula_finalmente {printf (" clausulas ->  clausula_finalmente\n"); }

clausulas_excepcion
	:[ clausula_excepcion_especifica ]* clausula_excepcion_general	{ printf ("  clausulas_excepcion ->[ clausula_excepcion_especifica ]* clausula_excepcion_general\n"); }
	|error ';' {yyerrok;}
	;

clausula_excepcion_especifica
	:’excepcion’ ’(’ nombre ’)’ [ instruccion ]+	{ printf ("  clausula_excepcion -> ’excepcion’ ’(’ nombre ’)’ [ instruccion ]+\n"); }
	;

clausula_excepcion_general 
: ’excepcion’ [ instruccion ]+ { printf ("  clausula_excepcion -> ’excepcion’ [ instruccion ]+\n"); }

clausula_finalmente
: ’finalmente’ [ instruccion ]+ {printf (" clausula_finalmente ->  ’finalmente’ [ instruccion ]+"); }




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
