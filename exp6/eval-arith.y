%{
 #include<stdio.h>
 void yyerror(const char *);
%}

%token digit
%left '*' '/' '+' '-'
%nonassoc UMINUS
%start S

%%
S: exp { printf("\nResult is: %d\n", $$); return 0; }

exp: exp'+'exp { $$ = $1 + $3; }
   | exp'-'exp { $$ = $1 - $3; }
   | exp'/'exp { if($3 == 0) {
                   printf("Divide by zero !!!");
                   return 0;
                 } else 
                    $$ = $1 / $3;
               }
   | exp'*'exp { $$ = $1 * $3; }
   | '(' exp ')' { $$ = $2; }
   | digit { $$ = $1; }
   ;

%%
main() {
 yyparse();
 return 0;
}

void yyerror(const char *s) {
 fprintf(stderr, "%s", s);
}
