%{
#include <iostream>
#include "snazzle.tab.h"
using namespace std;
#define YY_DECL extern "C" int yylex()

int lines = 0;

%}
%%
[ \t\n] ;
sNaZZle        { return SNAZZLE; }
type           { return TYPE; }
end            { return END; }
\/		       { return SLASH; }
:			   { return COLON; }
\{			   { return LEFT_BRACE; }
\}			   { return RIGHT_BRACE; }
\[			   { return LEFT_SQUARE; }
\] 			   { return RIGHT_SQUARE; }
,			   { return COMMA; }
#			   { return HASH; }
\%			   { return PERCENTAGE; }
!			   { return INTERJECTION; }
= 			   { return EQUAL; }
\<			   { return LESS_THEN; }
\>			   { return MORE_THEN; }
\>=			   { return MORE_EQUAL_THEN; }
\<=			   { return LESS_EQUAL_THEN; }
C			   { return CONSTRAINT; }
A			   { return AUTOINCREMENT; }
\\			   { return BACKSLASH; }
\(			   { return LEFT_BRACKET; }
\)			   { return RIGHT_BRACKET; }
-			   { return MINUS; }
\@	   	   	   { return HEADER_DATA; }
 
[[0-9]*\.[0-9]*,[0-9]*\.[0-9]*,[0-9]*\.[0-9]*,[0-9]*\.[0-9]*]]  { return DIRECTION; } 
[0-9]+\.[0-9]+ { yylval.dval = atof(yytext); return DOUBLE; }
[0-9]+         { yylval.ival = atoi(yytext); return INT; }
[a-zA-Z0-9]+   {
	// we have to copy because we can't rely on yytext not changing underneath us:
	yylval.sval = strdup(yytext);
	return VARCHAR;
}

.              ;
%%

/*main(int argc, char **argv)
{
	yylex();
	printf("%8d\n", lines);
}*/
