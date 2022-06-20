%option noyywrap

vowel [aeiouAEIOU]
consonants [bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]
line \n
symbol [$#@]

%{
 #include<stdio.h>
 int vowelCnt = 0, consCnt = 0, lineCnt = 0, symbolCnt = 0;
%}

%%
{vowel} { vowelCnt++; } 
{consonants} { consCnt++; }
{line} { lineCnt++; }
{symbol} { symbolCnt++; }

%%
main() {
 yyin = fopen("input.txt", "r");
 yylex();
 printf("\nVowels: %d\nConsonants: %d\n", vowelCnt, consCnt);
 printf("Lines: %d\nSymbols: %d\n", lineCnt, symbolCnt);
}
