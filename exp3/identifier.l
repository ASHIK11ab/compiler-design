%option noyywrap

identifier [a-zA-Z_][a-zA-Z_0-9]*

%{
 #include<stdio.h>
%}

%%
{identifier} { printf("Valid identifier"); }
.* { printf("Invalid identifier"); }

%%
main() {
 yylex();
}
