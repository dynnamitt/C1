%{
#include <stdio.h>
#include <stdlib.h>

extern int yylineno;
int yylex();
void yyerror(char *s);

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
void yyerror( char * s) {
	fprintf( stderr, "At lineno %d, ", yylineno );
	fprintf( stderr, "shit happens, msg: ' %s '\n", s );
	exit(-1);
}

int main(){
    yyparse();
    return 0;
}


