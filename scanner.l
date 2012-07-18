%option noyywrap nodefault 
%option case-insensitive 

%x COMMENT
%x SPRITE
%x MAP
%{

%}

%%
<COMMENT>.   /* ignore */
<COMMENT>\n   { BEGIN INITIAL; }

<SPRITE>^"]]" { printf("\]\]\n"); BEGIN INITIAL; }
<SPRITE>[^\n]* { printf( "\t%s" , yytext ); }
<SPRITE>\n { printf("\n"); /* NoToken */ }

<MAP>"}" { printf("\n}\n"); BEGIN INITIAL; }
<MAP>"QUANTUM" { printf(" @Quantum "); }
<MAP>"TIME" { printf(" @Time "); }
<MAP>"SPEED" { printf(" @Speed "); }
<MAP>"COLOR" { printf(" @Color "); }
<MAP>":" { printf(":");  }
<MAP>"," { printf(",\n");  }
<MAP>[0-9]+ { printf(" INT(%s) ", yytext ); }
<MAP>[^ \t\n:,\}]+ { printf(" TXT(%s) ", yytext ); }
<MAP>[ \t\n] /* irrelevant */

"DURATION" { printf("\n_Duration_"); }
"SEED" { printf("\n_Seed_"); }
"PLAYER-ATTRIB" { printf("\n_Player-attrib_"); }
"PLAYER-SPRITE" { printf("\n_Player-sprite_"); }
"BADGUY" { printf("\n_Badguy_"); }
"SILVER" { printf("\n_Silver_"); }
"FRAME" { printf("\n_Frame_"); }
"BOTTOMLINE" { printf("\n_BottomLine_"); }
"[["[ \t]*\n { printf("\n\[\[\n"); BEGIN SPRITE; }
[ \t]\{[ \t\n]* { printf(" {\n"); BEGIN MAP; }
^"{"[ \t]*$ { printf(" {\n"); BEGIN MAP; }
[0-9]+ { printf(" INT(%s) ", yytext ); }
^[ \t]*"#" { printf("# "); BEGIN COMMENT; }
\"[^ \t\n"]+\" { printf(" TXT(%s) ", yytext ); }
'[^ \t\n']+' { printf(" TXT(%s) ", yytext ); }
[ \t][^ \t\n\{\"']+/[ \t] { printf(" TXT(%s) ", yytext ); }
[ \t\n]   /* irrelevant */
. { printf( " ~(%s) " , yytext ); /* trash */ } 
%%

int main()
{
	yylex();
	return 0;
}
