%{
 #include<stdio.h>
 #include<stdlib.h>
 #include<string.h>
 #define max 20
 void yyerror(const char *);
 int tableSize = 0;

 struct node {
    char *name;
    /* Left and right node entry points to the entry in
      the table where the node is stored (index) */
    int leftNodeTableEntry;
    int rightNodeTableEntry;
 } *root;

 // Table to hold all of the created nodes.
 struct node *table[max];


  // Index of the node in the DAG table.
 int getNodeTableEntry(char *data) {
   int i;
   for(i = 0; i < tableSize; ++i)
   if(strcmp(table[i]->name, data) == 0)
      return i;

   return -1;
 }


 struct node* makeNode(char *data, struct node* leftNode, struct node* rightNode) {
    if(tableSize == max - 1)
       yyerror("DAG table size overflow !!!");

    int nodeEntry = getNodeTableEntry(data);
    
    // Return reference of the node when aldready exists.
    if(nodeEntry != -1) {
       struct node *temp = table[nodeEntry];
       return temp;
    }
    
    struct node *temp;
    temp = (struct node*) malloc(sizeof(struct node));
    
    // Index of the nodes in the tables.
    int leftNodeEntry = getNodeTableEntry(leftNode->name);
    int rightNodeEntry = getNodeTableEntry(rightNode->name);

    temp->name = data;
    temp->leftNodeTableEntry = leftNodeEntry;
    temp->rightNodeTableEntry = rightNodeEntry;
    
    // Add a new node to table.
    table[tableSize] = temp;
    tableSize++;

    return temp;
 }


  struct node* makeLeafNode(char *data) {
    if(tableSize == max - 1)
      yyerror("DAG table size overflow !!!");

    int nodeEntry = getNodeTableEntry(data);

    // Return reference of the node when aldready exists.
    if(nodeEntry != -1) {
       struct node *temp = table[nodeEntry];
       return temp;
    }

    struct node *temp;
    temp = (struct node*) malloc(sizeof(struct node));

    temp->name = data;
    temp->leftNodeTableEntry = -1;
    temp->rightNodeTableEntry = -1;
    
    // Add a new node to table.
    table[tableSize] = temp;
    tableSize++;

    return temp;
 }


 void printDAG() {
   if(tableSize == 0) {
      printf("No nodes in DAG");
      return;
   }

   printf("\nLine\tNode\tLeft\tRight");
   printf("\n-------------------------------");
   int i;
   struct node *temp;
   for(i = 0; i < tableSize; ++i) {
      temp = table[i];
      printf("\n%d\t%s\t%d\t%d", i, temp->name, 
               temp->leftNodeTableEntry, temp->rightNodeTableEntry);
   }
 }
%}

%union {
   struct node *n;
   char *name;
}

%token <name> digit id
%type <n> S exp
%left '*' '/' '+' '-' '%'
%right '='
%nonassoc UMINUS
%start S

%%
S: exp { root = $$; return 0; }

exp: exp '+' exp { $$ = makeNode("+", $1, $3); }
   | exp '-' exp { $$ = makeNode("-", $1, $3); }
   | exp '*' exp { $$ = makeNode("*", $1, $3); }
   | exp '%' exp { $$ = makeNode("%", $1, $3); }
   | exp '=' exp { $$ = makeNode("=", $1, $3); }
   | '(' exp ')' { $$ = $2; }
   | digit { $$ = makeLeafNode($1); }
   | id { $$ = makeLeafNode($1); }
   ;

%%
main() {
 root = NULL;
 printf("\nEnter expression: ");
 yyparse();
 printf("\n\nDAG:\n");
 printDAG();
 printf("\n");
 return 0;
}

void yyerror(const char *s) {
 fprintf(stderr, "%s", s);
}
