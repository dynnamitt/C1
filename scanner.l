%option noyywrap nodefault 
%option case-insensitive yylineno

%x COMMENT
%x SPRITE
%x MAP
%{
#include <stdlib.h>
#include "parser.tab.h"
#include "level.h"
%}

%%
<COMMENT>.   /* ignore */
<COMMENT>\n   { BEGIN INITIAL; }
	
<SPRITE>^"]]" { BEGIN INITIAL; return SPRITE_END; }
<SPRITE>[^\n]+ { yylval.string = strdup(yytext); return SPRITE_STRING; }
<SPRITE>\n /* jump along */

<MAP>"}" { BEGIN INITIAL; return '}'; }
<MAP>"QUANTUM" { yylval.string=strdup(yytext); return KEY; }
<MAP>"TIME" { yylval.string=strdup(yytext); return KEY; }
<MAP>"SPEED" { yylval.string=strdup(yytext); return KEY; }
<MAP>"COLOR" { yylval.string=strdup(yytext); return KEY; }
<MAP>":" { return ':'; }
<MAP>"," { return ','; }
<MAP>[0-9]+ { yylval.num = atoi(yytext); return INT; }
<MAP>[^ \t\n:,\}]+ { yylval.string=strdup(yytext); return TXT; }
<MAP>[ \t\n] /* irrelevant */

"TITLE" { yylval.num = TITLE; return OBJECT; }
"DURATION" { yylval.num = DURATION; return OBJECT; }
"SEED" { yylval.num = SEED; return OBJECT; }
"PLAYER-ATTRIB" { yylval.num = PLAYER_ATTRIB; return OBJECT; }
"PLAYER-SPRITE" { yylval.num = PLAYER_SPRITE; return OBJECT; }
"BADGUY" { yylval.num = BADGUY; return OBJECT; }
"SILVER" { yylval.num = SILVER; return OBJECT;  }
"FRAME" { yylval.num = FRAME; return OBJECT; } 
"BOTTOMLINE" { yylval.num = BOTTOMLINE; return OBJECT; }
"[["[ \t]*\n { BEGIN SPRITE; return SPRITE_BEGIN; }
[ \t]\{[ \t\n]* { BEGIN MAP; return '{'; }
^"{"[ \t]*$ { BEGIN MAP; return '{'; }
[0-9]+ { yylval.num = atoi(yytext); return INT; }
^[ \t]*"#" { BEGIN COMMENT; }
\"[^"]+\" { yylval.string=strdup(yytext); return TXT; }
'[^']+' { yylval.string=strdup(yytext); return TXT; }
[ \t][^ \t\n\{\"']+/[ \t] { yylval.string = strdup(&yytext[1]); return TXT; }
[ \t\n]   /* irrelevant */
. { fprintf( stderr, " ~(%s) " , yytext ); /* trash */ } 
%%

