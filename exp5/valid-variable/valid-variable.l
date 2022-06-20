%option noyywrap

variable [a-zA-Z_][a-zA-Z_0-9]*

%{
 #include"y.tab.h"
%}

%%
{variable} { return var; }
. { return notVar; }
