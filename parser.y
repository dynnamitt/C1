%{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "level.h"
#include "parser-support.h"


Level_t * lvl;
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
	  | level OBJECT data { printf("<%s> \n" ,obj_names[$2]); push( lvl, $2, NULL, $3); } 
      | level OBJECT TXT data { printf("<%s>——>(%s) \n",  obj_names[$2], $3 ); push( lvl, $2, $3, $4); }
;
data : TXT { printf("txt(%s)",$1); }
	  | INT { printf("int(%d)",$1); }
	  | '{' map '}' { $$ = $2; puts_map($2,4); }
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
sprite : SPRITE_STRING          { $$ = sprite_append( calloc( 1, SPRITE_SIZE ) , $1 ); }
       | sprite SPRITE_STRING   { $$ = sprite_append( $1 , $2 ); }
;
%%






int main(){
    
    /* TODO: move into parser and return PTR? */
    lvl = malloc( sizeof(struct Level_t) );

    yyparse();
    /*lvl_puts_level( lvl );*/
    return 0;
}
