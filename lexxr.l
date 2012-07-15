%option noyywrap nodefault
%x COMMENT
%x CDATA
%{

%}

%%
<COMMENT>.   /* now do nothing */
<COMMENT>\n   { BEGIN INITIAL; }

<CDATA>^"]]" { printf("\n\]\]\n"); BEGIN INITIAL; }
<CDATA>[^\n]+ { printf("%s"); }
<CDATA>\n { printf("\n"); }

"duration" { printf(" Duration.\t"); }
"seed" { printf(" Seed.\t"); }
"player-colors" { printf(" Player-colors.\t"); }
"player-sprite" { printf(" Player-sprite.\t"); }
"badguy" { printf(" Badguy.\t"); }
"silver" { printf(" Silver.\t"); }
"frame" { printf(" Frame.\t"); }

"[[" { printf("\n[[\n"); BEGIN CDATA; }

"{" { printf("\n{\n"); }
"}" { printf("\n}\n");  }
":" { printf(":");  }
"," { printf(",");  }

[0-9]+ { printf("NUM(%s)\t ", yytext ); }
[ \t] { printf(" "); }

\n { printf("<CRLF>\n"); }
^[ \t]*"#" { printf("COMMENT-LINE\n", yytext); BEGIN COMMENT; }

.+ { printf("TXT(%s)\t", yytext ); }
%%

int main()
{
	yylex();
	return 0;
}
