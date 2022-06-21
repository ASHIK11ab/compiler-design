%option noyywrap

digit [0-9]+
identifier [a-zA-Z_][a-zA-Z_0-9]*

%{ 
 #include"y.tab.h"
 extern YYSTYPE yylval;
%}

%%
{digit} { yylval.name = yytext; return digit; }
{identifier} { yylval.name = strdup(yytext); return id; }
\n { return 0; }
. { return yytext[0]; }
