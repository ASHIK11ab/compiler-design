#include<stdio.h>
#include<string.h>

struct SymbolTable {
 char type[50][10];
 char name[50][10];
} table;

int tableIndex = 0;

void printTable() {
 printf("\nTYPE\tVARIABLE\tADDRESS");
 printf("\n--------------------------------------");
 for(int i = 0; i < tableIndex; ++i) {
  printf("\n%s\t%s\t%p", table.type[i], table.name[i], table.name[i]);
 }
 printf("\n");
}

void main() {
  char line[200];
  char *token, *type;
  FILE *file;
  file = fopen("./input.txt", "r");
  
  while( !feof(file) ) {
   fgets(line, 100, file);
   token = strtok(line, " ");
   type = token;

   if( (strcmp(type, "int") != 0) && (strcmp(type, "float") != 0) 
	&& (strcmp(type, "char") != 0) && (strcmp(type, "void") != 0) )
    continue;


   while( (token = strtok(NULL, ",;\n")) != NULL) {
    strcpy(table.type[tableIndex], type);
    strcpy(table.name[tableIndex], token);
    tableIndex++;
   }    
  }

  printTable();

  fclose(file);
}
