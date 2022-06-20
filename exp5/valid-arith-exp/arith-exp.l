%option noyywrap

digit [0-9]+
identifier [a-zA-Z_][a-zA-Z_0-9]*

%{ 
 #include"y.tab.h"
%}

%%
{digit} { yylval = atoi(yytext); return digit; }
{identifier} { return id; }
\n { return 0; }
. { return yytext[0]; }
