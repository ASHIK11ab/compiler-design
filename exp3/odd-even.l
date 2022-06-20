%option noyywrap

digit [0-9]+

%{
 #include<stdio.h>
%}

%%
(\+|\-)?{digit}*[02468] { printf("Even number"); }
(\+|\-)?{digit}*[13579] { printf("Odd number"); }
.* { printf("Not a number"); }

%%
main() {
 yylex();
}
