 
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

/******************/
/* DECLARACION PROGRAMAS Y LIBRERIAS */

programa
 : definicion_programa {printf("EXITO: programa -> definicion_programa\n");}
 | definicion_libreria {printf("EXITO: programa -> definicion_libreria\n");}
 ;

definicion_programa
 : PROGRAMA IDENTIFICADOR ';' codigo_programa {printf("definicion_programa -> PROGRAMA IDENTIFICADOR ';' codigo_porgrama\n");}
 | error ';' {yyerrok;}
 ;

codigo_programa
 : cuerpo_subprograma {printf("codigo_programa -> cuerpo_subprograma\n");}
 | librerias cuerpo_subprograma {printf("codigo_programa -> librerias cuerpo_subprograma\n");}
 ;

librerias
 : libreria {printf("librerias -> libreria\n");}
 | librerias libreria {printf("librerias -> librerias libreria\n");}
 ;

libreria
 : IMPORTAR LIBRERIA nombre ';' {printf("libreria -> IMPORTAR LIBRERIA nombre ';'\n");}
 | IMPORTAR LIBRERIA nombre COMO IDENTIFICADOR ';' {printf("libreria -> IMPORTAR LIBRERIA nombre COMO IDENTIFICADOR ';'\n");}
 | DE LIBRERIA nombre IMPORTAR identificadores ';' {printf("libreria -> DE LIBRERIA nombre IMPORTAR identificadores\n");}
 ;


nombre: IDENTIFICADOR {printf("nombre-> IDENTIFICADOR\n");}
 | nombre CUATRO_PUNTOS IDENTIFICADOR {printf("nombre -> nombre CUATRO_PUNTOS IDENTIFICADOR\n");}
 ; 

nombres
 : nombre {printf("nombres -> nombre\n");}
 | nombres ',' nombre {printf("nombres -> nombres ',' nombre\n");}
 ;


definicion_libreria
 : LIBRERIA IDENTIFICADOR ';' codigo_libreria  {printf("defincion_libreria -> LIBRERIA IDENTIFICADOR ';' codigo_libreria\n");}
 ;

codigo_libreria
 :  declaraciones  {printf("codigo_libreria -> declaraciones\n");}
 | exportaciones declaraciones  {printf("codigo_libreria -> exportaciones declaraciones\n");}
 | librerias declaraciones {printf("codigo_libreria -> librerias declaraciones\n");}
 | librerias exportaciones declaraciones {printf("codigo_librerias -> librerias exportaciones declaraciones\n");}
 | error ';' {yyerrok;}
 ;

exportaciones
 : EXPORTAR nombres ';' {printf("exportaciones -> EXPORTAR nombres ';'\n");}
 ;

declaracion
 : declaracion_objeto {printf("declaracion -> declaracion_objeto\n");}
 | declaracion_tipo {printf("declaracion -> declaracion_tipo\n");}
 | declaracion_subprograma  {printf("declaracion -> declaracion_subprograma\n");}
 ;

declaraciones
 : declaracion {printf("declaraciones -> declaracion\n");}
 | declaraciones declaracion {printf("declaraciones -> declaraciones declaracion\n");}
 ;


/****************************************OBJETOS******************************************/

declaracion_objeto 
 : identificadores ':' CONSTANTE especificacion_tipo ASIGNACION expresion ';' {printf( "declaracion_objeto -> ( identificadores ) ':' especificacion_tipo ';'\n" );}
 | identificadores ':' especificacion_tipo  ASIGNACION expresion ';' {printf( "declaracion_objeto -> ( identificadores ) ':' especificacion_tipo [ ASIGNACION expresion ] ';'\n" );}
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
 | SIGNO tipo_basico	{printf("tipo_escalar -> [ SIGNO ] tipo_basico\n");}
 | tipo_basico longitud{printf("tipo_escalar -> tipo_basico [ longitud ]\n");}
 | tipo_basico RANGO rango {printf("tipo_escalar -> tipo_basico [ RANGO rango ]\n");}
 | SIGNO  tipo_basico longitud{printf("tipo_escalar -> [ SIGNO ] tipo_basico [ longitud ]\n");}
 | tipo_basico longitud RANGO rango {printf("tipo_escalar -> tipo_basico [ longitud ] [ RANGO rango ]\n");}
 | SIGNO tipo_basico RANGO rango {printf("tipo_escalar -> [ SIGNO ] tipo_basico [ RANGO rango ]\n");}
 | SIGNO tipo_basico longitud RANGO rango {printf("tipo_escalar -> tipo_basico\n");}
 | error ';' {yyerrok;}
 ;

longitud 
 : CORTO {printf("longirud -> CORTO\n");}
 | LARGO {printf("longirud -> LARGO\n");}
 ;

tipo_basico 
 : BOOLEANO {printf("tipo_basico -> BOOLEANO\n ");} 
 | CARACTER {printf("tipo_basico -> CARACTER\n ");}
 | ENTERO {printf("tipo_basico -> ENTERO\n ");}
 | REAL {printf("tipo_basico -> REAL\n ");}
 ;

rango 
 : expresion DOS_PUNTOS expresion {printf("rango -> expresion DOS_PUNTOS expresion\n ");}
 | expresion DOS_PUNTOS expresion DOS_PUNTOS expresion {printf("rango -> expresion DOS_PUNTOS expresion [ DOS_PUNTOS expresion ]\n ");}
 ;

tipo_tabla  
 : TABLA '(' expresion DOS_PUNTOS expresion ')' DE especificacion_tipo {printf("tipo_tabla -> TABLA '(' expresion DOS_PUNTOS expresion ')' DE especificacion_tipo\n ");}
 | LISTA DE especificacion_tipo {printf("tipo_tabla -> LISTA DE especificacion_tipo\n ");}
 ;

tipo_diccionario 
 : DICCIONARIO DE especificacion_tipo {printf("tipo_diccionario -> DICCIONARIO DE especificacion_tipo\n ");}
 ;

tipo_estructurado 
 : tipo_registro {printf("tipo_estructurado -> tipo_registro\n ");}
 | tipo_enumerado {printf("tipo_estructurado -> tipo_enumerado\n ");}
 | clase {printf("tipo_estructurado -> clase\n ");}
 ;

tipo_registro 
 : REGISTRO campos FIN REGISTRO {printf("tipo_registro -> REGISTRO campos FIN REGISTRO\n ");}
 ;

campo 
 : identificadores ':' especificacion_tipo ';' {printf("campo -> identificadores ':' especificacion_tipo  ';'\n ");}
 | identificadores ':' especificacion_tipo ASIGNACION expresion ';' {printf("campo -> identificadores ':' especificacion_tipo [ ASIGNACION expresion ] ';'\n ");}
 ;

campos
 : campo {printf("campos -> campo\n ");}
 | campos campo {printf("campos -> campos campo\n ");}
 ;

tipo_enumerado 
 : ENUMERACION elementos_enumeracion FIN ENUMERACION {printf("tipo_enumerado -> ENUMERACION elementos_enumeracion FIN ENUMERACION\n ");}
 | ENUMERACION DE tipo_escalar elementos_enumeracion FIN ENUMERACION {printf("tipo_enumerado -> ENUMERACION [ DE tipo_escalar ] elementos_enumeracion FIN ENUMERACION\n ");}
 ;

elemento_enumeracion 
 : IDENTIFICADOR {printf("elemento_enumeracion -> IDENTIFICADOR\n ");}
 | IDENTIFICADOR ASIGNACION expresion {printf("elemento_enumeracion -> IDENTIFICADOR [ ASIGNACION expresion ]\n ");}
 ;

elementos_enumeracion
 : elemento_enumeracion {printf("elementos_enumeracion -> elemento_enumeracion\n ");}
 | elementos_enumeracion elemento_enumeracion {printf("elementos_enumeracion -> elementos_enumeracion elemento_enumeracion\n ");}
 ;


/****************************************CLASES******************************************/

clase 
 : CLASE declaracion_componentes FIN CLASE {printf("clase -> CLASE [ declaraciones_componente ] FIN CLASE\n ");}
 | CLASE ULTIMA declaracion_componentes FIN CLASE {printf("clase -> CLASE [ ULTIMA ] [ declaraciones_componente ] FIN CLASE\n ");}
 | CLASE superclases declaracion_componentes FIN CLASE {printf("clase -> CLASE [ superclases ] [ declaraciones_componente ] FIN CLASE\n ");}
 | CLASE ULTIMA superclases declaracion_componente FIN CLASE {printf("clase -> CLASE [ ULTIMA ] [ superclases ] [ declaracion_componente ] FIN CLASE\n ");}
 | error ';' {yyerrok;}
 ;

superclases
 : '(' nombres ')' {printf("superclases -> '(' nombres ')'\n");}
 ;

declaracion_componentes
 : declaracion_componente {printf("declaracion_componentes -> declaracion_componente\n");}
 | declaracion_componentes declaracion_componente {printf("declaracion_componentes -> declaracion_componentes declaracion_componente\n");}


declaracion_componente 
 : componente  {printf("declaracion_componente -> componente\n");}
 | visibilidad componente  {printf("declaracion_componente -> [ visibilidad ] componente\n");}
 ;

visibilidad 
 : PUBLICO {printf("visibilidad -> PUBLICO\n");}
 | PROTEGIDO {printf("visibilidad -> PROTEGIDO\n");}
 | PRIVADO{printf("visibilidad -> PRIVADO\n");}
 ;

componente 
 : declaracion_tipo {printf("componente -> declaracion_tipo\n");}
 | declaracion_objeto {printf("componente -> declaracion_objeto\n");}
 | modificadores declaracion_subprograma {printf("componente -> modificadores declaracion_subprograma\n");}
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
 : modificador {printf("modificadores -> modificador\n");}
 | modificadores ',' modificador {printf("modificadores -> modificadores ',' modificador\n");}
 ;


/**************************************SUBPROGRAMAS***************************************/

declaracion_subprograma
 : SUBPROGRAMA cabecera_subprograma cuerpo_subprograma SUBPROGRAMA {printf("declaracion_subprograma -> SUBPROGAMA cabecera_subprograma cuerpo_subprograma SUBPROGAMA\n ");}

cabecera_subprograma 
 : IDENTIFICADOR {printf("cabecera_subprograma ->  IDENTIFICADOR\n");}
 | IDENTIFICADOR parametrizacion {printf("cabecera_subprograma ->  IDENTIFICADOR [ parametrizacion ]\n");}
 | IDENTIFICADOR tipo_resultado {printf("cabecera_subprograma ->  IDENTIFICADOR [ tipo_resultado ]\n");}
 | IDENTIFICADOR parametrizacion tipo_resultado {printf("cabecera_subprograma ->  IDENTIFICADOR [ parametrizacion ] [ tipo_resultado ]\n");}
 | error ';' {yyerrok;}
 ;

parametrizacion 
 : '(' declaracion_parametros ')' {printf("parametrizacion -> '(' declaracion_parametros')'\n");}
 | '(' declaracion_parametros ';' declaracion_parametros ')' {printf("parametrizacion -> '(' [ declaracion_parametros ';'] declaracion_parametros')'\n");}
 ;

declaracion_parametros
 : identificadores ':' especificacion_tipo  {printf("declaracion_parametros -> identificadores ':' especificacion_tipo\n");}
 | identificadores ':' modo especificacion_tipo {printf("declaracion_parametros -> identificadores ':' modo especificacion_tipo\n");} 
 | identificadores ':' especificacion_tipo ASIGNACION expresion {printf("declaracion_parametros -> identificadores ':' especificacion_tipo ASIGNACION expresion \n");}
 | identificadores ':' modo especificacion_tipo ASIGNACION expresion {printf("declaracion_parametros -> identificadores ':' modo especificacion_tipo ASIGNACION expresion\n");}
 | error ';' {yyerrok;}
 ;

identificadores
 : IDENTIFICADOR {printf("identificadores -> IDENTIFICADOR\n");}
 | identificadores ',' IDENTIFICADOR {printf("identificadores -> identificadores ',' IDENTIFICADOR\n");}
 ;

modo
 : VALOR {printf("modo-> VALOR\n");}
 | REFERENCIA {printf("modo -> REFERENCIA\n");}

tipo_resultado
 : DEVOLVER especificacion_tipo {printf("tipo_resultado -> DEVOLVER especificacion_tipo\n");}

cuerpo_subprograma
 : PRINCIPIO bloque_instrucciones FIN {printf (" cuerpo_subprograma -> PRINCIPIO bloque_instrucciones FIN\n");}
 | declaraciones PRINCIPIO bloque_instrucciones FIN {printf (" cuerpo_subprograma -> [ declaraciones ] PRINCIPIO bloque_instrucciones FIN\n");}
 ;


/*************************************INSTRUCCIONES**************************************/

bloque_instrucciones
 : instruccion {printf("bloques_instrucciones -> instruccion\n");}
 | bloque_instrucciones instruccion  {printf("bloques_instrucciones -> bloques_instrucciones instruccion\n");}
 ;

instruccion
 : ';'	{printf ("  instruccion -> ';'\n");}
 | instruccion_asignacion  {printf ("  instruccion -> instruccion_asignacion\n");}
 | instruccion_devolver	{printf ("  instruccion -> instruccion_devolver\n");}
 | instruccion_llamada	{printf ("  instruccion -> instruccion_llamada\n");}
 | instruccion_si		{printf ("  instruccion -> instruccion_si\n");}
 | instruccion_casos	{printf ("  instruccion -> instruccion_casos\n");}
 | instruccion_bucle	{printf ("  instruccion -> instruccion_bucle\n");}
 | instruccion_interrupcion	{printf ("  instruccion -> instruccion_interrupcion\n");}
 | instruccion_lanzamiento_excepcion	{printf ("  instruccion -> instruccion_lanzamiento_excepcion\n");}
 | instruccion_captura_excepcion	{printf ("  instruccion -> instruccion_captura_excepcion\n");}
 | error ';' {yyerrok;}
 ;

instruccion_asignacion
 :objeto op_asignacion expresion ';'	{printf ("  instruccion_asignacion -> objeto op_asignacion expresion ';'\n");}
 ;

 op_asignacion
 : ASIGNACION {printf ("  op_asignacion -> ASIGNACION\n");}
 | ASIG_SUMA {printf ("  op_asignacion -> ASIG_SUMA\n");}
 | ASIG_RESTA {printf ("  op_asignacion -> ASIG_RESTA_n");}
 | ASIG_MULT {printf ("  op_asignacion -> ASIG_MULTn");}
 | ASIG_DIV {printf ("  op_asignacion -> ASIG_DIV\n");}
 | ASIG_POT {printf ("  op_asignacion -> ASIG_POT\n");}
 | ASIG_RESTO {printf ("  op_asignacion -> ASIG_RESTO\n");}
 | ASIG_DESPI {printf ("  op_asignacion -> ASIG_DESPI\n");}
 | ASIG_DESPD {printf ("  op_asignacion -> ASIG_DESPD\n");}
 ;

instruccion_devolver
 : DEVOLVER	';' {printf ("  instruccion_devolver -> DEVOLVER ';'\n");}
 | DEVOLVER expresion ';' {printf ("  instruccion_devolver -> DEVOLVER [ expresion ] ';'\n");}
 ;

instruccion_llamada
 : llamada_subprograma ';'	{printf ("  instruccion_llamada -> llamada_subprograma\n");}
 ;

llamada_subprograma
 : nombre '(' ')' {printf("llamada_subprograma -> nombre '('  ')'\n");}
 | nombre '(' definicion_parametros ')' {printf("llamada_subprograma -> nombre '(' definicion_parametros ')'\n");}
 ;
 
 definicion_parametros
 : definicion_parametro {printf("definicion_parametros -> definicion_parametros\n");}
 | definicion_parametros ',' definicion_parametro {printf("definicion_parametros -> definicion_parametros definicion_parametro\n");}
 ;

definicion_parametro 
 : expresion {printf("definicion_parametro -> expresion\n");}
 |IDENTIFICADOR ASIGNACION expresion {printf("definicion_parametro -> IDENTIFICADOR ASIGNACION expresion\n");}
 ;

instruccion_si 
 : SI expresion ENTONCES bloque_instrucciones FIN SI {printf("instruccion_si -> SI expresion ENTONCES bloque_instrucciones FIN SI\n");}
 | SI expresion ENTONCES bloque_instrucciones SINO bloque_instrucciones FIN SI {printf("instruccion_si ->  SI expresion ENTONCES bloque_instrucciones SINO bloque_instrucciones FIN SI\n");}
 ;

instruccion_casos
 : CASOS expresion ES casos FIN CASOS ';'	{printf ("  instruccion_casos -> CASOS expresion ES casos + FIN CASOS';'\n");}	
 ;

casos
 : caso {printf("casos -> caso\n");}
 | casos caso {printf("casos -> casos caso\n");}
 ;

caso
 : CUANDO entradas FLECHA bloque_instrucciones	{printf ("  caso ->CUANDO entradas FLECHA bloque_instrucciones\n");}	
 ;

entradas 
 : entrada {printf("entradas -> entrada\n");}
 | entradas ':' entrada {printf("entradas -> entradas ':' entrada\n");}
 ;

entrada
 : expresion {printf("entrada -> expresion\n");}
 | expresion DOS_PUNTOS expresion {printf("entrada -> expresion ['..'  expresion]\n");}
 | OTRO
 ;

instruccion_bucle
 : clausula_iteracion bloque_instrucciones FIN BUCLE {printf("instruccion_bucle -> clausula_iteracion bloque_instrucciones FIN BUCLE\n");}
 | IDENTIFICADOR ':' clausula_iteracion bloque_instrucciones FIN BUCLE	{printf ("  instruccion_bucle -> [ IDENTIFICADOR ':' ] clausula_iteracion bloque_instrucciones FIN BUCLE\n");}
 ;

clausulas_iteraciones
 : clausula_iteracion {printf("clausulas_iteraciones -> clausula_iteracion\n");}
 |clausulas_iteraciones clausula_iteracion {printf("clausulas_iteraciones -> clasulas_iteraciones clausula_iteracion\n");}
 ;

clausula_iteracion
 : PARA IDENTIFICADOR EN expresion {printf ("  clausula_iteracion -> PARA IDENTIFICADOR EN expresion \n");}
 | PARA IDENTIFICADOR ':' especificacion_tipo EN expresion {printf ("  clausula_iteracion -> PARA IDENTIFICADOR EN  [ ':' especificacion_tipo ]  expresion \n");}
 | REPETIR IDENTIFICADOR EN RANGO {printf ("  clausula_iteracion ->REPETIR IDENTIFICADOR EN rango\n");}
 | REPETIR IDENTIFICADOR ':' especificacion_tipo EN RANGO {printf ("  clausula_iteracion ->REPETIR IDENTIFICADOR [ ':' especificacion_tipo ] EN rango\n");}
 | REPETIR IDENTIFICADOR EN RANGO DESCENDENTE {printf ("  clausula_iteracion ->REPETIR IDENTIFICADOR EN rango DESCENDENTE\n");}
 | REPETIR IDENTIFICADOR ':' especificacion_tipo EN RANGO DESCENDENTE {printf ("  clausula_iteracion ->REPETIR IDENTIFICADOR [ ':' especificacion_tipo ] EN rango [ DESCENDENTE ]\n");}
 | MIENTRAS expresion {printf ("  clausula_iteracion -> MIENTRAS expresion \n");}
 | error ';' {yyerrok;}
 ;

instruccion_interrupcion 
 : SIGUIENTE ';' {printf("instruccion_interrupcion -> SIGUIENTE ';'\n");}
 | SIGUIENTE CUANDO ';' {printf("instruccion_interrupcion -> SIGUIENTE cuando ';'\n");}
 | SALIR ';' {printf("instruccion_interrupcion -> SALIR ';'\n");}
 | SALIR DE IDENTIFICADOR ';' {printf("instruccion_interrupcion -> SALIR DE IDENTIFICADOR ';'\n");}
 | SALIR CUANDO ';' {printf("instruccion_interrupcion -> SALIR cuando ';'\n");}
 | SALIR DE IDENTIFICADOR CUANDO ';' {printf("instruccion_interrupcion -> SALIR DE IDENTIFICADOR cuando ';'\n");}
 ;

instruccion_lanzamiento_excepcion
 : LANZA nombre ';' {printf (" instruccion_lanzamiento_excepcion ->  LANZA nombre\n");}
 ;

instruccion_captura_excepcion
 : PRUEBA bloque_instrucciones clausulas FIN PRUEBA  {printf (" instruccion_captura_excepcion -> PRUEBA bloque_instrucciones clausulas FIN PRUEBA\n");}
 ;

clausulas
 : clausulas_excepcion {printf (" clausulas -> clausulas_excepcion\n");}
 | clausulas [ clausula_finalmente ] {printf (" clausulas -> clausulas_excepcion\n");}
 | clausula_finalmente {printf (" clausulas ->  clausula_finalmente\n");}
 ;

clausulas_excepcion
 : clausula_excepcion_general	{printf ("  clausulas_excepcion -> clausula_excepcion_general\n");}
 |clausula_excepcion_especifica clausula_excepcion_general	{printf ("  clausulas_excepcion -> [clausula_excepcion_especifica] clausula_excepcion_general\n");}
 | error ';' {yyerrok;}
 ;

clausula_excepcion_especifica
 : EXCEPCION '(' nombre ')' bloque_instrucciones	{printf ("  clausula_excepcion_especifica -> EXCEPCION '(' nombre ')' bloque_instrucciones\n");}
 ;

clausula_excepcion_general 
 : EXCEPCION bloque_instrucciones {printf ("  clausula_excepcion_general -> EXCEPCION bloque_instrucciones\n");}

clausula_finalmente
 : FINALMENTE bloque_instrucciones {printf (" clausula_finalmente ->  FINALMENTE bloque_instrucciones");}


/*************************************EXPRESIONES**************************************/

expres
 : expresion {printf ("expres-> expresion\n");}
 | expres ',' expresion {printf("expres -> expres expresion\n");}
 ;

expresion
 : expresion1{printf("expresion -> expresion1\n");}
 ;

expresion1
 : expresion1 OR expresion2 {printf("expresion1 -> expresion1 OR expresion2\n");}
 | expresion2 {printf("expresion1 -> expresion2\n" );}
 ;

expresion2
 : expresion2 AND expresion3 {printf("expresion2 -> expresion2 AND expresion3\n");}
 | expresion3 {printf("expresion2 -> expresion3\n");}
 ;

expresion3
 : '~' expresion4 {printf("expresion3 -> expresion3 ~ expresion4\n");}
 | expresion4 {printf("expresion3 -> expresion4\n");}
 ;

expresion4
 : expresion4 '<' expresion5 {printf("expresion4 -> expresion4 '<' expresion5\n");}
 | expresion4 '>' expresion5 {printf("expresion4 -> expresion4 '>' expresion5\n");}
 | expresion4 LEQ expresion5 {printf("expresion4 -> expresion4 LEQ expresion5\n");}
 | expresion4 GEQ expresion5 {printf("expresion4 -> expresion4 GEQ expresion5\n");}
 | expresion4 '=' expresion5 {printf("expresion4 -> expresion4 '=' expresion5\n");}
 | expresion4 NEQ expresion5 {printf("expresion4 -> expresion4 NEQ expresion5\n");}
 | expresion5 {printf("expresion4 -> expresion5\n");}
 ;

expresion5
 : expresion5 DESPI expresion6 {printf("expresion5 -> expresion5 DESPI expresion6\n");}
 | expresion5 DESPD expresion6 {printf("expresion5 -> expresion4 DESPD expresion5\n");}
 | expresion6 {printf("expresion5 -> expresion5 -> expresion6\n");}
 ;

expresion6
 : expresion6 '+' expresion7 {printf("expresion6 -> expresion6 '+' expresion7\n");}
 | expresion6 '-' expresion7 {printf("expresion6 -> expresion6 '-' expresion7\n");}
 | expresion7 {printf("expresion6 -> expresion6 -> expresion7\n");}
 ;

expresion7
 : expresion7 '*' expresion_potencia {printf("expresion7 -> expresion7 '*' expresion_potencia\n");}
 | expresion7 '/' expresion_potencia {printf("expresion7 -> expresion7 '/' expresion_potencia\n");}
 | expresion7 '\\' expresion_potencia {printf("expresion7 -> expresion7 '\\' expresion_potencia\n");}
 | expresion_potencia {printf("expresion7 ->expresion7 -> expresion_potencia\n");}
 ; 

expresion_potencia
 : expresion_posfija '^' expresion_potencia {printf("expresion_potencia ->  expresion_potencia '^' expresion_posfija\n");}
 | expresion_posfija {printf("expresion_potencia -> expresion_posfija\n");}
 ;

expresion_posfija
 : expresion_unaria operador_posfijo {printf("expresion_posfija -> expresion_unaria operador_posfijo\n");}
 | expresion_unaria {printf("expresion_posfija -> expresion_unaria\n");}
 ;

operador_posfijo
 : INC {printf(" operador_posfijo -> operador_posfijo INC\n");}
 | DEC {printf("operador_posfijo -> operador_posfijo DEC\n");}
 ;

expresion_unaria
 : '-' primario {printf("expresion_unaria -> '-' primario\n");}
 | primario {printf("expresion_unaria -> primario\n");}
 ;

primario
 : literal  {printf("primario -> literal\n");}
 | objeto  {printf("primario -> OBJETO\n");}
 | OBJETO llamada_subprograma {printf("primario -> OBJETO llamada_subprograma\n");}
 | llamada_subprograma  {printf("primario -> llamada_subprograma\n");}
 | enumeraciones  {printf("primario -> enumeraciones\n");}
 | '(' expresion ')' {printf("primario -> '(' expresion ')'\n");}
 ;

literal
 : VERDADERO {printf("literal -> VERDADERO\n");}
 | FALSO {printf("literal -> FALSO\n");}
 | CTC_ENTERA {printf("literal -> CTC_ENTERA\n");}
 | CTC_REAL   {printf("literal -> CTC_REAL\n");}
 | CTC_CARACTER {printf("literal -> CTC_CARACTER\n");}
 | CTC_CADENA {printf("literal -> CTC_CADENA\n");}
 ;

objeto
 : nombre {printf("objeto -> nombre\n");}
 | objeto '.' IDENTIFICADOR {printf("objeto ->  objeto '.' IDENTIFICADOR\n");}
 | objeto '[' expres ']' {printf("objeto -> objeto '[' expres ']'\n");}
 | objeto '{' ctc_cadenas '}' {printf("objeto -> '{' ctc_cadenas '}'\n");}
 ;

enumeraciones
 : '[' expresion_condicional clausulas_iteraciones ']' {printf("enumeraciones -> '[' expresion_condicional clausulas_iteraciones ']'\n");}
 | '['  expres  ']' {printf("enumeraciones -> '[' expres ']'\n");}
 | '{' claves_valor '}' {printf("enumeraciones -> '{' claves_valor '}'\n");}
 | '{' campos_valor '}' {printf("enumeraciones -> '{' campos_valor '}'\n");}
 ;

expresion_condicional
 : expresion {printf("expresion_condicional -> expresion\n");}
 | SI expresion ENTONCES expresion {printf("expresion_condicional -> SI expresion ENTONCES expresion\n");}
 | SI expresion ENTONCES expresion SINO expresion {printf("expresion_condicional-> SI expresion ENTONCES expresion SINO expresion\n");}
 ;

claves_valor
 : clave_valor {printf("claves_valor -> clave_valor\n");}
 | claves_valor ',' clave_valor {printf("claves_valor -> claves_valor clave_valor\n");}
 ;

campos_valor
 : campo_valor {printf("campos_valor-> campo_valor\n");}
 | campos_valor ',' campo_valor  {printf("campos_valor -> campos_valor campo_valor\n");}
 ; 

ctc_cadenas
 : CTC_CADENA {printf("ctc_cadenas -> CTC_CADENAS\n");}
 | ctc_cadenas ',' CTC_CADENA {printf("ctc_cadenas -> CTC_CADENAS\n");}
 ;

clave_valor
 : CTC_CADENA FLECHA expresion  {printf("clave_valor -> CTC_CADENA FLECHA expresion\n");}
 ;

campo_valor
 : IDENTIFICADOR FLECHA expresion  {printf("campo_valor -> IDENTIFICADOR FLECHA expresion\n");}
 ;


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
