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
<MAP>"QUANTUM" { yylval.num = K_QUANTUM; return KEY; }
<MAP>"TIME" { yylval.num = K_TIME; return KEY; }
<MAP>"SPEED" { yylval.num = K_SPEED; return KEY; }
<MAP>"COLOR" { yylval.num = K_COLOR; return KEY; }
<MAP>":" { return ':'; }
<MAP>"," { return ','; }
<MAP>[0-9]+ { yylval.num = atoi(yytext); return INT; }
<MAP>[^ \t\n:,\}]+ { yylval.string = strdup(yytext); return TXT; }
<MAP>[ \t\n] /* irrelevant */

"TITLE" { yylval.num = O_TITLE; return OBJECT; }
"DURATION" { yylval.num = O_DURATION; return OBJECT; }
"SEED" { yylval.num = O_SEED; return OBJECT; }
"PLAYER-ATTRIB" { yylval.num = O_PLAYER_ATTRIB; return OBJECT; }
"PLAYER-SPRITE" { yylval.num = O_PLAYER_SPRITE; return OBJECT; }
"BADGUY" { yylval.num = O_BADGUY; return OBJECT; }
"SILVER" { yylval.num = O_SILVER; return OBJECT;  }
"FRAME" { yylval.num = O_FRAME; return OBJECT; } 
"BOTTOMLINE" { yylval.num = O_BOTTOMLINE; return OBJECT; }
"[["[ \t]*\n { BEGIN SPRITE; return SPRITE_BEGIN; }
[ \t]\{[ \t\n]* { BEGIN MAP; return '{'; }
^"{"[ \t]*$ { BEGIN MAP; return '{'; }
[0-9]+ { yylval.num = atoi(yytext); return INT; }
^[ \t]*"#" { BEGIN COMMENT; }
\"[^"]+\"/[ \t\n] { yylval.string=strdup(yytext); return TXT; }
'[^']+'/[ \t\n] { yylval.string=strdup(yytext); return TXT; }
[ \t][^ \t\n\{\"']+/[ \t] { yylval.string = strdup(&yytext[1]); return TXT; }
[ \t\n]   /* irrelevant */
. { fprintf( stderr, " ~(%s) " , yytext ); /* trash */ } 
%%

