%option noyywrap

digit [0-9]+

%{
 #include<stdio.h>
%}

%%
-{digit} { printf("Negative digit"); }
{digit}|\+{digit} { printf("Positive digit"); }
.* { printf("Not a digit"); }

%%
main() {
 yylex();
}
