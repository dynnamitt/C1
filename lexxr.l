%option noyywrap nodefault 
%option case-insensitive 

%x COMMENT
%x SPRITE
%x ATTRIB
%{
_Bool sprite_new = 0;
%}

%%
<COMMENT>.   /* ignore */
<COMMENT>\n   { BEGIN INITIAL; }

<SPRITE>^"]]" { printf("\]\]\n"); BEGIN INITIAL; }
<SPRITE>[^\n]* { printf( "\t%s" , yytext ); }
<SPRITE>\n { if (sprite_new) { 
		sprite_new=0; 
	} else {
		printf("\n");
	}
/* shouldnt printf if at first line. NoToken */ }

<ATTRIB>"}" { printf("\n}\n"); BEGIN INITIAL; }
<ATTRIB>"QUANTUM" { printf(" @Quantum "); }
<ATTRIB>"TIME" { printf(" @Time "); }
<ATTRIB>"SPEED" { printf(" @Speed "); }
<ATTRIB>"COLOR" { printf(" @Color "); }
<ATTRIB>":" { printf(":");  }
<ATTRIB>"," { printf(",\n");  }
<ATTRIB>[0-9]+ { printf(" INT-VAL(%s) ", yytext ); }
<ATTRIB>[^ \t\n:]+ { printf(" TXT-VAL(%s) ", yytext ); }
<ATTRIB>[ \t\n] /* irrelevant */

"DURATION" { printf("\n_Duration_"); }
"SEED" { printf("\n_Seed_"); }
"PLAYER-ATTRIB" { printf("\n_Player-attrib_"); }
"PLAYER-SPRITE" { printf("\n_Player-sprite_"); }
"BADGUY" { printf("\n_Badguy_"); }
"SILVER" { printf("\n_Silver_"); }
"FRAME" { printf("\n_Frame_"); }
"BOTTOMLINE" { printf("\n_BottomLine_"); }
"[["[ \t]*$ { printf("\n\[\[\n"); sprite_new=1; BEGIN SPRITE; }
" {"[ \t\n]* { printf(" {\n"); BEGIN ATTRIB; }
^"{"[ \t]*$ { printf(" {\n"); BEGIN ATTRIB; }
[0-9]+ { printf(" INT(%s) ", yytext ); }
^[ \t]*"#" { printf("# "); BEGIN COMMENT; }
["]?[^ \t\n"]+["]? { printf(" TXT(%s) ", yytext ); }
[']?[^ \t\n']+[']? { printf(" TXT(%s) ", yytext ); }
[ \t\n] /* irrelevant */
. { printf( "~" ); } /**/
%%

int main()
{
	yylex();
	return 0;
}
