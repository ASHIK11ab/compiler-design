%option noyywrap

digit [0-9]+

%{ 
 #include"y.tab.h"
 extern int yylval;
%}

%%
{digit} { yylval = atoi(yytext); return digit; }
\n { return 0; }
. { return yytext[0]; }
