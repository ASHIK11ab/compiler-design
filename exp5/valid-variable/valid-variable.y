%{
#include<stdio.h>
void yyerror(const char *);
%}

%token var notVar

%%
S: var { printf("Valid variable"); return 0; }
 | notVar { printf("Not a variable"); return 0; }

%%
main() {
 yyparse();
}

void yyerror(const char *s) {
 fprintf(stderr, "%s", s);
}
