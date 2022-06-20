%option noyywrap

vowel [aeiouAEIOU]
consonants [bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]

%{
 #include<stdio.h>
 int vowelsCnt = 0, consCnt = 0;
%}

%%
{vowel} { vowelsCnt++; } 
{consonants} { consCnt++; }

%%
main() {
 yylex();
 printf("\nVowels: %d\nConsonants: %d\n", vowelsCnt, consCnt);
}
