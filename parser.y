%{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "level.h"



/* how can we move these into .h */


struct Keyval { Key key; int val; };

struct Map { int len; struct Keyval * elems[]; };

extern int yylineno;

/* funcs */
int yylex();
void yyerror(char *s);

/* custom */
struct Keyval * newkeyval(Key k, int v);
struct Map * newmap(const struct Keyval * kv);

%}

%union {
	int num;
	char * string;
	struct Map * map;
	struct Keyval * keyval;
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
level : /* zelo */
	  | level OBJECT value { printf("——>  <%s> \n" ,obj_names[$2]); } 
      | level OBJECT TXT value { printf("(%s)——> <%s> \n", $3, obj_names[$2]); }
;
value : TXT { printf("txt(%s)",$1); }
	  | INT { printf("int(%d)",$1); }
	  | '{' map '}'
	  | SPRITE_BEGIN sprite SPRITE_END { /* calc max len? */ } 
; 
map : keyval     { printf("(%s=%d) ", map_key_names[$1->key] , $1->val ); }
    | map ',' keyval { printf("(%s=%d) ", map_key_names[$3->key] , $3->val ); /* append */ }
;
keyval : KEY ':' TXT { $$ = newkeyval($1, color_lookup($3) ); }
       | KEY ':' INT { $$ = newkeyval($1, $3); }
       | KEY TXT { $$ = newkeyval($1, color_lookup($2) ); }
       | KEY INT { $$ = newkeyval($1, $2); }

;
sprite : SPRITE_STRING          { printf("%s\n", $1); }
       | sprite SPRITE_STRING   { printf("%s\n", $2); /* append */ }
;
%%

struct Keyval * newkeyval(Key k, int v){
    struct Keyval * kv = malloc( sizeof(struct Keyval) );
    assert(kv && "Cannot create Keyval var.");
    kv->key = k;
    kv->val = v;
    return kv;
}

struct Map * newmap(struct Keyval * kv)
{
    size_t map_sz1 = sizeof(struct Map) + sizeof(struct Keyval); 
    struct Map * m = malloc( map_sz1 );
    assert(m && "Cannot create Map var.");
    
    m->len = 1;
    m->elems[0] = kv;
    return m;
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
