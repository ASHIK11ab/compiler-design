%option noyywrap

line \n

singleLineComment "//".*
multiLineComment "/*".*|.*"*/"
comment {singleLineComment}|{multiLineComment}

preprocessor #.*
dataType "int"|"float"|"char"|"double"|"void"
keyword "for"|"if"|"while"|"switch"|"return"|"break"|"continue"

operator "+"|"-"|"*"|"/"|"%"|"="
digit [0-9]+
variable [a-zA-Z_][a-zA-Z_0-9]*

identifier {variable}|{digit}
function {variable}\(.*\)

%{
 #include<stdio.h>
 int lineCnt = 0;
%}

%%
{line} { lineCnt++; }
{comment} { printf("\nLine no: %d, %s is a comment", lineCnt, yytext); }
{preprocessor} { printf("\nLine no: %d, %s is a preprocessor", lineCnt, yytext); }
{keyword} { printf("\nLine no: %d, %s is a keyword", lineCnt, yytext); }
{dataType} { printf("\nLine no: %d, %s is a data type", lineCnt, yytext); }
{operator} { printf("\nLine no: %d, %s is a operator", lineCnt, yytext); }
{function} { printf("\nLine no: %d, %s is a function\n", lineCnt, yytext); }
{identifier} { printf("\nLine no: %d, %s is a identifier", lineCnt, yytext); }
. { }

%%

main() {
 yyin = fopen("input.txt", "r");
 yylex();
}
