%option noyywrap nodefault 
%option case-insensitive

%x COMMENT
%x SPRITE
%x ATTRIB
%{

%}

%%
<COMMENT>.   /* now do nothing */
<COMMENT>\n   { BEGIN INITIAL; }

<SPRITE>^"]]" { printf("\]\]\n"); BEGIN INITIAL; }
<SPRITE>[^\n]* { printf( "\t%s" , yytext ); }
<SPRITE>\n { printf("\n"); /* no token */ }

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

"DURATION" { printf("_Duration_"); }
"SEED" { printf("_Seed_"); }
"PLAYER-ATTRIB" { printf("_Player-attrib_"); }
"PLAYER-SPRITE" { printf("_Player-sprite_"); }
"BADGUY" { printf("_Badguy_"); }
"SILVER" { printf("_Silver_"); }
"FRAME" { printf("_Frame_"); }
"BOTTOMLINE" { printf("_BottomLine_"); }
"[["[ \t]*\n { printf("\n\[\[\n"); BEGIN SPRITE; }
"{" { printf(" {\n"); BEGIN ATTRIB; }
[0-9]+ { printf(" INT(%s) ", yytext ); }
^[ \t]*"#" { printf("# ", yytext); BEGIN COMMENT; }
[^ \t\n]+ { printf(" TXT(%s) ", yytext ); }
[ \t\n] /* irrelevant */
. { printf( "~" ); } /**/
%%

int main()
{
	yylex();
	return 0;
}
