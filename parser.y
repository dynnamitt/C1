%{
#include <stdio.h>
#include <stdlib.h>
#include "level.h"



struct KEYVAL {
	Map_key key;
	int val;
};


extern int yylineno;
int yylex();
void yyerror(char *s);
struct KEYVAL * newkeyval(Map_key k, int v);
%}

%union {
	int num;
	char * string;
	struct KEYVAL * keyval;
}

%token <num> OBJECT
%token <string> TXT
%token <num> INT
%token SPRITE_BEGIN
%token SPRITE_END
%token <string> SPRITE_STRING
%token <num> KEY

%type <keyval> keyval
/* 
    also used is '{' '}' ',' ':' 
*/


%%
level : /* zeo */
	  | level OBJECT value { printf("%d found.\n",$2); } 
      | level OBJECT TXT value { printf("%d found.\n",$2); }
;
value : TXT { printf("txt(%s)",$1); }
	  | INT { printf("int(%d)",$1); }
	  | '{' map '}'
	  | SPRITE_BEGIN sprite SPRITE_END 
; 
map : keyval     { printf("key=%d | val=%d > ", $1->key , $1->val ); }
    | map ',' keyval /* append */
;
keyval : KEY ':' TXT { $$ = newkeyval($1, 1111); }
       | KEY ':' INT { $$ = newkeyval($1, $3); }
       | KEY TXT { $$ = newkeyval($1, 1112); }
       | KEY INT { $$ = newkeyval($1, $2); }

;
sprite : SPRITE_STRING          { printf("%s\n", $1); }
       | sprite SPRITE_STRING   { printf("%s\n", $2); }
;
%%

struct KEYVAL * newkeyval(Map_key k, int v){
    struct KEYVAL * kv = malloc( sizeof(struct KEYVAL) );
    kv->key = k;
    kv->val = v;
    return kv;
}

void yyerror( char * s) {
	fprintf( stderr, "At lineno %d, ", yylineno );
	fprintf( stderr, "an ERROR, msg: '%s'\n", s );
	exit(-1);
}


int main(){
    yyparse();
    return 0;
}


