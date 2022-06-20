%{
 #include<stdio.h>
 void yyerror(const char *);
%}

%token digit id
%left '*' '/' '+' '-'
%start S

%%
S: exp { printf("Valid expression\n"); return 0; }
 ;

exp: exp'+'exp
   | exp'-'exp
   | exp'/'exp
   | exp'*'exp
   | id
   | digit
   ;

%%
main() {
 yyparse();
}

void yyerror(const char *s) {
 fprintf(stderr, "%s", s);
}
