%{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "level.h"







extern int yylineno;

/* funcs */
int yylex();
void yyerror(char *s);

/* only needed in here */
struct Keyval { Key key; int val; };

/* custom funcs */
struct Keyval * newkeyval(Key k, int v);
Map_t newmap(const struct Keyval * kv);


%}

%union {
	int num;
	char * string;
	int * map; /* Map_t */
	struct Keyval * keyval;
    void * data;
}

%token <num> OBJECT
%token <string> TXT
%token <num> INT
%token SPRITE_BEGIN
%token SPRITE_END
%token <string> SPRITE_STRING
%token <num> KEY

%type <keyval> keyval
%type <map> map
%type <data> data

/* 
    also used is '{' '}' ',' ':' 
*/


%%
level : /* zelo */
	  | level OBJECT data { printf("——>  <%s> \n" ,obj_names[$2]); } 
      | level OBJECT TXT data { printf("(%s)——> <%s> \n", $3, obj_names[$2]); }
;
data : TXT { printf("txt(%s)",$1); }
	  | INT { printf("int(%d)",$1); }
	  | '{' map '}' { $$ = $2; lvl_puts_map($2,2); }
	  | SPRITE_BEGIN sprite SPRITE_END { /* calc max len? */ } 
; 
map : keyval     { $$ = newmap($1); free($1); }
    | map ',' keyval { $1[$3->key] = $3->val; free($3); /* append */ }
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

struct Keyval * newkeyval(Key k, int v)
{
    struct Keyval * kv = malloc( sizeof(struct Keyval) );
    assert(kv && "Cannot create Keyval var.");
    kv->key = k;
    kv->val = v;
    return kv;
}

Map_t newmap(const struct Keyval * kv)
{
    Map_t m = malloc( sizeof(int) * NMAPKEYS ) ; 
    assert(m && "Cannot create Map_t var.");	
    int i;
    for( i = 0; i < NMAPKEYS; i++ ) {
	    m[i] = VAL_UNDEF;
    }
    if( kv != NULL) {    
        m[kv->key] = kv->val;
    }
    return (int*)m;
}

void yyerror( char * s)
{
	fprintf( stderr, "At lineno %d, ", yylineno );
	fprintf( stderr, "an ERROR, msg: '%s'\n", s );
	exit(-1);
}

int main(){
    yyparse();
    return 0;
}
