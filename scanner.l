%option noyywrap nodefault 
%option case-insensitive yylineno

%x COMMENT
%x SPRITE
%x MAP
%{
#include <stdlib.h>
#include "parser.tab.h"
%}

%%
<COMMENT>.   /* ignore */
<COMMENT>\n   { BEGIN INITIAL; }
	
<SPRITE>^"]]" { BEGIN INITIAL; return SPRITE_END; }
<SPRITE>[^\n]+ { yylval.string = strdup(yytext); return SPRITE_STRING; }
<SPRITE>\n /* jump along */

<MAP>"}" { BEGIN INITIAL; return yytext[0]; }
<MAP>"QUANTUM" { yylval.string=strdup(yytext); return KEY; }
<MAP>"TIME" { yylval.string=strdup(yytext); return KEY; }
<MAP>"SPEED" { yylval.string=strdup(yytext); return KEY; }
<MAP>"COLOR" { yylval.string=strdup(yytext); return KEY; }
<MAP>":" { return ':'; }
<MAP>"," { return ','; }
<MAP>[0-9]+ { yylval.num = atoi(yytext); return INT; }
<MAP>[^ \t\n:,\}]+ { yylval.string=strdup(yytext); return TXT; }
<MAP>[ \t\n] /* irrelevant */

"DURATION" { yylval.string = strdup(yytext); return OBJECT; }
"SEED" { yylval.string = strdup(yytext); return OBJECT; }
"PLAYER-ATTRIB" { yylval.string = strdup(yytext); return OBJECT; }
"PLAYER-SPRITE" { yylval.string = strdup(yytext); return OBJECT; }
"BADGUY" { yylval.string = strdup(yytext); return OBJECT; }
"SILVER" { yylval.string = strdup(yytext); return OBJECT;  }
"FRAME" { yylval.string = strdup(yytext); return OBJECT; } 
"BOTTOMLINE" { yylval.string = strdup(yytext); return OBJECT; }
"[["[ \t]*\n { BEGIN SPRITE; return SPRITE_BEGIN; }
[ \t]\{[ \t\n]* { BEGIN MAP; return '{'; }
^"{"[ \t]*$ { BEGIN MAP; return '{'; }
[0-9]+ { yylval.num = atoi(yytext); return INT; }
^[ \t]*"#" { BEGIN COMMENT; }
\"[^ \t\n"]+\" { yylval.string=strdup(yytext); return TXT; }
'[^ \t\n']+' { yylval.string=strdup(yytext); return TXT; }
[ \t][^ \t\n\{\"']+/[ \t] { puts("!"); yylval.string = strdup(&yytext[1]); return TXT; }
[ \t\n]   /* irrelevant */
. { fprintf( stderr, " ~(%s) " , yytext ); /* trash */ } 
%%

