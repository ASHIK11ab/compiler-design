%{
 #include<stdio.h>
 #include<stdlib.h>
 void yyerror(const char *);

 struct node {
    char *name;
    struct node *left;
    struct node *right;
 } *root;


 struct node* makeNode(char *data, struct node *left, struct node *right) {
    struct node *temp;
    temp = (struct node*) malloc(sizeof(struct node));

    temp->name = data;
    temp->left = left;
    temp->right = right;

    return temp;
 }


  struct node* makeLeafNode(char *data) {
    struct node *temp;
    temp = (struct node*) malloc(sizeof(struct node));

    temp->name = data;
    temp->left = NULL;
    temp->right = NULL;

    return temp;
 }


 void preorder(struct node *temp) {
   if(temp == NULL)
      return;

   printf("%s -> ", temp->name);
   preorder(temp->left);
   preorder(temp->right);
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
   | digit { $$ = makeLeafNode($1); }
   | id { $$ = makeLeafNode($1); }
   ;

%%
main() {
 root = NULL;
 yyparse();
 printf("\nPreorder traversal:\n");
 preorder(root); 
 printf("\n");
 return 0;

 /* 
  exp'+'exp { struct node *interiorNode = makeNode('+', $1, $3);
                  $$ = interiorNode;
                  root = interiorNode;
               }
   | exp'-'exp { struct node *interiorNode = makeNode('-', $1, $3);
                  $$ = interiorNode;
                  root = interiorNode;
               }
   | exp'/'exp { struct node *interiorNode = makeNode('+', $1, $3);
                  $$ = interiorNode;
                  root = interiorNode;
               }
   | exp'*'exp { struct node *interiorNode = makeNode('+', $1, $3);
                  $$ = interiorNode;
                  root = interiorNode;
               }
   | '(' exp ')' { $$ = $2; }
  */
}

void yyerror(const char *s) {
 fprintf(stderr, "%s", s);
}
