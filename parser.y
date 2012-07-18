%{
#include <stdio.h>
%}

%union {
	int num;
	char * string;
}

%token <string> OBJECT
%token <string> TXT
%token <num> INT
%token SPRITE_BEGIN
%token SPRITE_END
%token <string> SPRITE_STRING
%token <string> KEY
/* 
    also used is '{' '}' ',' ':' 
*/


%%
level : /* zero */
	  | level OBJECT value
      | level OBJECT TXT value
;
value : TXT
	  | INT
	  | '{' map '}'
	  | SPRITE_BEGIN sprite SPRITE_END 
; 
map : keyval     /* first one */
    | map ',' keyval /* append */
;
keyval : KEY ':' TXT
       | KEY ':' INT
       | KEY TXT
       | KEY INT
;
sprite : SPRITE_STRING          /* first one */
       | sprite SPRITE_STRING   /* append */
;
%%
int main(){
    yyparse();
    return 0;
}

void yyerror(const char * s, ...) {
	fprintf( stderr, "At lineno %d, ", yylineno );
	fprintf( stderr, " shit happens: %s \n", s );
	exit(-1);
}
