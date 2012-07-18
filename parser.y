%{

%}
%token OBJECT
%token TXT
%token INT
%token SPRITE_BEGIN
%token SPRITE_END
%token SPRITE_STRING
%token KEY
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
keyval : KEY ':' TXTmake clea
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
