%{
#include <stdio.h>
#include <stdlib.h>

typedef union {
	int num;
	char * string;
} Value_t;

typedef struct {
	char * key;
	Value_t * val;
} Keyval_t;


extern int yylineno;
int yylex();
void yyerror(char *s);

%}
%YYTYPE Value_t;

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
level : /* zeo */
	  | level OBJECT value { printf("%s found.\n",$2); } 
      | level OBJECT TXT value { printf("%s found.\n",$2); }
;
value : TXT { printf("txt(%s)",$1); }
	  | INT { printf("int(%d)",$1); }
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
	fprintf( stderr, "shit happens. Msg: ' %s '\n", s );
	exit(-1);
}

int main(){
    yyparse();
    return 0;
}


