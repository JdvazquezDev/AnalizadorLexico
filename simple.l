

%%


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
    }
  }
