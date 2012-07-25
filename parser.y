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
Sprite_t sprite_append(Sprite_t sprite, char * str);

%}

%union {
	int num;
	char * string;
	int * map; /* Map_t */
    char ** sprite; /* Sprite_t */
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
%type <sprite> sprite

/* 
    also used is '{' '}' ',' ':' 
*/


%%
level : /* zelo */ 
	  | level OBJECT data { printf("<%s> \n" ,obj_names[$2]); } 
      | level OBJECT TXT data { printf("<%s>——>(%s) \n",  obj_names[$2], $3 ); }
;
data : TXT { printf("txt(%s)",$1); }
	  | INT { printf("int(%d)",$1); }
	  | '{' map '}' { $$ = $2; lvl_puts_map($2,4); }
	  | SPRITE_BEGIN sprite SPRITE_END { $$ = $2; lvl_puts_sprite($2,10); } 
; 
map : keyval     { $$ = newmap($1); free($1); }
    | map ',' keyval { $1[$3->key] = $3->val; free($3); /* append */ }
;
keyval : KEY ':' TXT { $$ = newkeyval($1, color_lookup($3) ); }
       | KEY ':' INT { $$ = newkeyval($1, $3); }
       | KEY TXT { $$ = newkeyval($1, color_lookup($2) ); }
       | KEY INT { $$ = newkeyval($1, $2); }

;
sprite : SPRITE_STRING          { $$ = sprite_append( calloc( 1, sizeof(char**) ) , $1 ); }
       | sprite SPRITE_STRING   { $$ = sprite_append( $1 , $2 ); }
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

//! \brief Not quite clever shit yet 
Sprite_t sprite_append(Sprite_t sprite, char * str)
{
   assert(sprite && "Cannot handle NULL ptr."
        " Need atleast one elem pointing to NULL string");

    Sprite_t start_p = sprite;
    int len = 1;
    
    if ( *sprite != NULL ) {
        /* nav to NULL */
        while(*sprite) 
            ++sprite;
    
        len += sprite - start_p;
    }

    *sprite = str; /* set str into LAST elem */

    ++len;
    size_t sz = sizeof(char**) * (len) ;
    
    Sprite_t realloced_ptr = (Sprite_t)realloc(start_p, sz);

    assert(realloced_ptr && "Cannot expand var.");

    realloced_ptr[len-1] = NULL;
    return realloced_ptr;
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
