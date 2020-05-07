 
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


/****************************************OBJETOS******************************************/

declaracion_objeto 
 : ( identificadores ) ':' CONSTANTE especificacion_tipo ASIGNACION expresion ';' {printf( "declaracion_objeto -> ( identificadores ) ':' especificacion_tipo ';'\n" );}
 | ( identificadores ) ':' especificacion_tipo [ ASIGNACION expresion ] ';' {printf( "declaracion_objeto -> ( identificadores ) ':' especificacion_tipo [ ASIGNACION expresion ] ';'\n" );}
 ;
 
especificacion_tipo 
 : nombre {printf( "especificacion_tipo -> nombre\n" );}
 | tipo_no_estructurado {printf( "especificacion_tipo -> tipo_no_estructurado\n" );}
 ;


/****************************************TIPOS******************************************/

declaracion_tipo 
 : TIPO IDENTIFICADOR ES tipo_no_estructurado ';' {printf("declaracion_tipo -> TIPO IDENTIFICADOR ES tipo_no_estructurado\n");}
 | TIPO IDENTIFICADOR ES tipo_estructurado {printf("declaracion_tipo -> TIPO IDENTIFICADOR ES tipo_estructurado\n");}
 ;

tipo_no_estructurado 
 : tipo_escalar {printf("tipo_no_estructurado -> tipo_escalar\n");}
 | tipo_tabla {printf("tipo_no_estructurado -> tipo_tabla\n");}
 | tipo_diccionario {printf("tipo_no_estructurado -> tipo_diccionario\n");}
 | error ';' {yyerrok;}
 ;

tipo_escalar 
 : tipo_basico {printf("tipo_escalar -> tipo_basico\n");}  
 | [ SIGNO ] tipo_basico	{printf("tipo_escalar -> [ SIGNO ] tipo_basico\n");}
 | tipo_basico [ longitud ] {printf("tipo_escalar -> tipo_basico [ longitud ]\n");}
 | tipo_basico [ RANGO rango ] {printf("tipo_escalar -> tipo_basico [ RANGO rango ]\n");}
 | [ SIGNO ] tipo_basico [ longitud ] {printf("tipo_escalar -> [ SIGNO ] tipo_basico [ longitud ]\n");}
 | tipo_basico [ longitud ] [ RANGO rango ]{printf("tipo_escalar -> tipo_basico [ longitud ] [ RANGO rango ]\n");}
 | [ SIGNO ] tipo_basico [ RANGO rango ] {printf("tipo_escalar -> [ SIGNO ] tipo_basico [ RANGO rango ]\n");}
 | [ SIGNO ] tipo_basico [ longitud ] [ RANGO rango ]{printf("tipo_escalar -> tipo_basico\n");}
 | error ';' {yyerrok;}
 ;

longitud 
 : CORTO {printf("longirud -> CORTO\n");}
 | LARGO {printf("longirud -> LARGO\n");}
 ;

tipo_basico 
 : BOOLEANO {printf(" tipo_basico -> BOOLEANO\n ");} 
 | CARACTER {printf(" tipo_basico -> CARACTER\n ");}
 | ENTERO {printf(" tipo_basico -> ENTERO\n ");}
 | REAL {printf(" tipo_basico -> REAL\n ");}
 ;

rango 
 : expresion DOS_PUNTOS expresion {printf(" rango -> expresion DOS_PUNTOS expresion \n ");}
 | expresion DOS_PUNTOS expresion [ DOS_PUNTOS expresion ] {printf(" rango -> expresion DOS_PUNTOS expresion [ DOS_PUNTOS expresion ] \n ");}
 ;

tipo_tabla  
 : TABLA '(' expresion DOS_PUNTOS expresion ')' DE especificacion_tipo {printf(" tipo_tabla -> TABLA '(' expresion DOS_PUNTOS expresion ')' DE especificacion_tipo \n ");}
 | LISTA DE especificacion_tipo {printf(" tipo_tabla -> LISTA DE especificacion_tipo \n ");}
 ;

tipo_diccionario 
 : DICCIONARIO DE especificacion_tipo {printf(" tipo_diccionario -> DICCIONARIO DE especificacion_tipo \n ");}
 ;

tipo_estructurado 
 : tipo_registro {printf(" tipo_estructurado -> tipo_registro \n ");}
 | tipo_enumerado {printf(" tipo_estructurado -> tipo_enumerado \n ");}
 | clase {printf(" tipo_estructurado -> clase \n ");}
 ;

tipo_registro 
 : REGISTRO campos FIN REGISTRO {printf(" tipo_registro -> REGISTRO campos FIN REGISTRO \n ");}
 ;

campo 
 : identificadores ':' especificacion_tipo ';' {printf(" campo -> identificadores ':' especificacion_tipo  ';' \n ");}
 | identificadores ':' especificacion_tipo [ ASIGNACION expresion ] ';' {printf(" campo -> identificadores ':' especificacion_tipo [ ASIGNACION expresion ] ';' \n ");}
 ;

campos
 : campo {printf(" campos -> campo \n ");}
 | campos campo {printf(" campos -> campos campo \n ");}
 ;

tipo_enumerado 
 : ENUMERACION elementos_enumeracion FIN ENUMERACION {printf(" tipo_enumerado -> ENUMERACION elementos_enumeracion FIN ENUMERACION \n ");}
 | ENUMERACION [ DE tipo_escalar ] elementos_enumeracion FIN ENUMERACION {printf(" tipo_enumerado -> ENUMERACION [ DE tipo_escalar ] elementos_enumeracion FIN ENUMERACION \n ");}
 ;

elemento_enumeracion 
 : IDENTIFICADOR {printf(" elemento_enumeracion -> IDENTIFICADOR \n ");}
 | IDENTIFICADOR [ ASIGNACION expresion ] {printf(" elemento_enumeracion -> IDENTIFICADOR [ ASIGNACION expresion ] \n ");}
 ;

elementos_enumeracion
 : elemento_enumeracion {printf(" elementos_enumeracion -> elemento_enumeracion \n ");}
 | elementos_enumeracion elemento_enumeracion {printf(" elementos_enumeracion -> elementos_enumeracion elemento_enumeracion \n ");}
 ;


/****************************************CLASES******************************************/

clase 
 : CLASE [ declaracion_componentes ] FIN CLASE {printf(" clase -> CLASE [ declaraciones_componente ] FIN CLASE \n ");}
 | CLASE [ ULTIMA ] [ declaracion_componentes ] FIN CLASE {printf(" clase -> CLASE [ ULTIMA ] [ declaraciones_componente ] FIN CLASE \n ");}
 | CLASE [ superclases ] [ declaracion_componentes ] FIN CLASE {printf(" clase -> CLASE [ superclases ] [ declaraciones_componente ] FIN CLASE \n ");}
 | CLASE [ ULTIMA ] [ superclases ] [ declaracion_componente ]+ FIN CLASE {printf(" clase -> CLASE [ ULTIMA ] [ superclases ] [ declaracion_componente ] FIN CLASE \n ");}
 | error ';' {yyerrok;}
 ;

superclases
 : '(' nombres ')' {printf("superclases -> '(' nombres ')' \n")}
 ;

declaracion_componente 
 : componente  {printf("declaracion_componente -> componente \n")}
 | [ visibilidad ] componente  {printf("declaracion_componente -> [ visibilidad ] componente \n")}
 ;

visibilidad 
 : PUBLICO {printf("visibilidad -> PUBLICO \n")}
 | PROTEGIDO {printf("visibilidad -> PROTEGIDO \n")}
 | PRIVADO{printf("visibilidad -> PRIVADO \n")}
 ;

componente 
 : declaracion_tipo {printf("componente -> declaracion_tipo \n")}
 | declaracion_objeto {printf("componente -> declaracion_objeto \n")}
 | modificadores declaracion_subprograma {printf("componente -> modificadores declaracion_subprograma \n")}
 ;

modificador
 : CONSTRUCTOR {printf("modificador -> CONSTRUCTOR\n");}
 | DESTRUCTOR {printf("modificador -> DESTRUCTOR\n");}
 | GENERICO {printf("modificador -> GENERICO\n");}
 | ABSTRACTO {printf("modificador -> ABSTRACTO\n");}
 | ESPECIFICO {printf("modificador -> ESPECIFICO\n");}
 | FINAL {printf("modificador -> FINAL\n");}
 | error ';' {yyerrok;}
 ;

 modificadores 
 : modificador { printf(" modificadores -> modificador\n");}
 | modificadores ',' modificador { printf(" modificadores -> modificadores ',' modificador\n");}
 ;


/**************************************SUBPROGRAMAS***************************************/

declaracion_subprograma
 : SUBPROGAMA cabecera_subprograma cuerpo_subprograma SUBPROGAMA { printf(" declaracion_subprograma -> SUBPROGAMA cabecera_subprograma cuerpo_subprograma SUBPROGAMA\n ");}

cabecera_subprograma 
 : IDENTIFICADOR {printf(" cabecera_subprograma ->  IDENTIFICADOR \n");}
 | IDENTIFICADOR [ parametrizacion ]  {printf(" cabecera_subprograma ->  IDENTIFICADOR [ parametrizacion ] \n");}
 | IDENTIFICADOR [ tipo_resultado ]  {printf(" cabecera_subprograma ->  IDENTIFICADOR [ tipo_resultado ] \n");}
 | IDENTIFICADOR [ parametrizacion ] [ tipo_resultado ]  {printf(" cabecera_subprograma ->  IDENTIFICADOR [ parametrizacion ] [ tipo_resultado ] \n");}
 | error ';' {yyerrok;}
 ;

parametrizacion 
 : '(' declaracion_parametros ')' {printf(" parametrizacion -> '(' declaracion_parametros')' \n");}
 | '(' [ declaracion_parametros ';' ] declaracion_parametros ')' {printf(" parametrizacion -> '(' [ declaracion_parametros ';'] declaracion_parametros')' \n");}
 ;

declaracion_parametros
 : identificadores ':' especificacion_tipo  { printf(" declaracion_parametros -> identificadores ':' especificacion_tipo \n"); }
 | identificadores ':' modo especificacion_tipo { printf(" declaracion_parametros -> identificadores ':' modo especificacion_tipo \n"); } 
 | identificadores ':' especificacion_tipo ASIGNACION expresion { printf(" declaracion_parametros -> identificadores ':' especificacion_tipo ASIGNACION expresion  \n"); }
 | identificadores ':' modo especificacion_tipo ASIGNACION expresion { printf(" declaracion_parametros -> identificadores ':' modo especificacion_tipo ASIGNACION expresion \n"); }
 | error ';' {yyerrok;}
 ;

identificadores
 : IDENTIFICADOR { printf(" identificadores -> IDENTIFICADOR \n"); }
 | identificadores ',' IDENTIFICADOR { printf(" identificadores -> identificadores ',' IDENTIFICADOR \n"); }
 ;

cuerpo_subprograma
 : PRINCIPIO bloque_instrucciones FIN {printf (" cuerpo_subprograma -> PRINCIPIO bloque_instrucciones FIN \n");}
 | [ declaraciones ] PRINCIPIO bloque_instrucciones FIN {printf (" cuerpo_subprograma -> [ declaraciones ] PRINCIPIO bloque_instrucciones FIN \n");}
 ;


/*************************************INSTRUCCIONES**************************************/

bloque_instrucciones
 : instruccion { printf(" bloques_instrucciones -> instruccion\n"); }
 | bloque_instrucciones instruccion  { printf(" bloques_instrucciones -> bloques_instrucciones instruccion\n"); }
 ;

instruccion
 : ';'	{ printf ("  instruccion -> ';'\n"); }
 | instruccion_asignacion  { printf ("  instruccion -> instruccion_asignacion\n"); }
 | instruccion_devolver	{ printf ("  instruccion -> instruccion_devolver\n"); }
 | instruccion_llamada	{ printf ("  instruccion -> instruccion_llamada\n"); }
 | instruccion_si		{ printf ("  instruccion -> instruccion_si\n"); }
 | instruccion_casos	{ printf ("  instruccion -> instruccion_casos\n"); }
 | instruccion_bucle	{ printf ("  instruccion -> instruccion_bucle\n"); }
 | instruccion_interrupcion	{ printf ("  instruccion -> instruccion_interrupcion\n"); }
 | instruccion_lanzamiento_excepcion	{ printf ("  instruccion -> instruccion_lanzamiento_excepcion\n"); }
 | instruccion_captura_excepcion	{ printf ("  instruccion -> instruccion_captura_excepcion\n"); }
 | error ';' {yyerrok;}
 ;

instruccion_asignacion
 :objeto op_asignacion expresion ';'	{ printf ("  instruccion_asignacion -> objeto op_asignacion expresion ';'\n"); }
 ;

 op_asignacion
 : ASIGNACION { printf ("  op_asignacion -> ASIGNACION\n"); }
 | ASIG_SUMA { printf ("  op_asignacion -> ASIG_SUMA\n"); }
 | ASIG_RESTA { printf ("  op_asignacion -> ASIG_RESTA_n"); }
 | ASIG_MULT { printf ("  op_asignacion -> ASIG_MULTn"); }
 | ASIG_DIV { printf ("  op_asignacion -> ASIG_DIV\n"); }
 | ASIG_POT { printf ("  op_asignacion -> ASIG_POT\n"); }
 | ASIG_RESTO { printf ("  op_asignacion -> ASIG_RESTO\n"); }
 | ASIG_DESPI { printf ("  op_asignacion -> ASIG_DESPI\n"); }
 | ASIG_DESPD { printf ("  op_asignacion -> ASIG_DESPD\n"); }
 ;

instruccion_devolver
 : DEVOLVER	';' { printf ("  instruccion_devolver -> DEVOLVER ';' \n"); }
 | DEVOLVER [ expresion ] ';' { printf ("  instruccion_devolver -> DEVOLVER [ expresion ] ';' \n"); }
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
 : CUANDO entradas FLECHA bloque_instrucciones	{ printf ("  caso ->CUANDO entradas FLECHA bloque_instrucciones \n"); }	
 ;

entradas 
 : entrada { printf(" entradas -> entrada \n"); }
 | entradas ':' entrada { printf(" entradas -> entradas ':' entrada \n"); }
 ;

entrada
 : expresion { printf(" entrada -> expresion \n"); }
 | expresion DOS_PUNTOS expresion { printf(" entrada -> expresion ['..'  expresion]\n"); }
 | OTRO
 ;

instruccion_bucle
 : clausula_iteracion bloque_instrucciones FIN BUCLE { printf(" instruccion_bucle -> clausula_iteracion bloque_instrucciones FIN BUCLE \n"); }
 | IDENTIFICADOR ':' clausula_iteracion bloque_instrucciones FIN BUCLE	{ printf ("  instruccion_bucle -> [ IDENTIFICADOR ':' ] clausula_iteracion bloque_instrucciones FIN BUCLE \n"); }
 ;

clausula_iteracion
 : PARA IDENTIFICADOR EN expresion { printf ("  clausula_iteracion -> PARA IDENTIFICADOR EN expresion  \n"); }
 | PARA IDENTIFICADOR ':' especificacion_tipo EN expresion { printf ("  clausula_iteracion -> PARA IDENTIFICADOR EN  [ ':' especificacion_tipo ]  expresion  \n"); }
 | REPETIR IDENTIFICADOR EN RANGO { printf ("  clausula_iteracion ->REPETIR IDENTIFICADOR EN rango \n"); }
 | REPETIR IDENTIFICADOR ':' especificacion_tipo EN RANGO { printf ("  clausula_iteracion ->REPETIR IDENTIFICADOR [ ':' especificacion_tipo ] EN rango \n"); }
 | REPETIR IDENTIFICADOR EN RANGO [ DESCENDENTE ] { printf ("  clausula_iteracion ->REPETIR IDENTIFICADOR EN rango [ DESCENDENTE ] \n"); }
 | REPETIR IDENTIFICADOR ':' especificacion_tipo EN RANGO [ DESCENDENTE ] { printf ("  clausula_iteracion ->REPETIR IDENTIFICADOR [ ':' especificacion_tipo ] EN rango [ DESCENDENTE ] \n"); }
 | MIENTRAS expresion { printf ("  clausula_iteracion -> MIENTRAS expresion  \n"); }
 | error ';' {yyerrok;}
 ;

instruccion_interrupcion 
 : SIGUIENTE ';' { printf(" instruccion_interrupcion -> SIGUIENTE ';' \n"); }
 | SIGUIENTE CUANDO ';' { printf(" instruccion_interrupcion -> SIGUIENTE cuando ';' \n"); }
 | SALIR ';' { printf(" instruccion_interrupcion -> SALIR ';'\n"); }
 | SALIR DE IDENTIFICADOR ';' { printf(" instruccion_interrupcion -> SALIR DE IDENTIFICADOR ';' \n"); }
 | SALIR CUANDO ';' { printf(" instruccion_interrupcion -> SALIR cuando ';' \n"); }
 | SALIR DE IDENTIFICADOR CUANDO ';' { printf(" instruccion_interrupcion -> SALIR DE IDENTIFICADOR cuando ';' \n"); }
 ;

instruccion_lanzamiento_excepcion
 : LANZA nombre ';' {printf (" instruccion_lanzamiento_excepcion ->  LANZA nombre\n"); }
 ;

instruccion_captura_excepcion
 : PRUEBA bloque_instrucciones clausulas FIN PRUEBA  {printf (" instruccion_captura_excepcion -> PRUEBA bloque_instrucciones clausulas FIN PRUEBA\n"); }
 ;

clausulas
 : clausulas_excepcion {printf (" clausulas -> clausulas_excepcion \n"); }
 | clausulas [ clausula_finalmente ] {printf (" clausulas -> clausulas_excepcion \n"); }
 | clausula_finalmente {printf (" clausulas ->  clausula_finalmente\n"); }
 ;

clausulas_excepcion
 : clausula_excepcion_general	{ printf ("  clausulas_excepcion -> clausula_excepcion_general\n"); }
 |clausula_excepcion_especifica clausula_excepcion_general	{ printf ("  clausulas_excepcion -> [clausula_excepcion_especifica] clausula_excepcion_general\n"); }
 | error ';' {yyerrok;}
 ;

clausula_excepcion_especifica
 : EXCEPCION '(' nombre ')' bloque_instrucciones	{ printf ("  clausula_excepcion_especifica -> EXCEPCION '(' nombre ')' bloque_instrucciones\n"); }
 ;

clausula_excepcion_general 
 : EXCEPCION bloque_instrucciones { printf ("  clausula_excepcion_general -> EXCEPCION bloque_instrucciones\n"); }

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
