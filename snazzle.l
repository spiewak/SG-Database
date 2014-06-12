%{
#include <iostream>
#include "snazzle.tab.h"
using namespace std;
#define YY_DECL extern "C" int yylex()
%}
%%
[ \t\n] ;
sNaZZle        { return SNAZZLE; }
type           { return TYPE; }
end            { return END; }
,	       { return COMMA; }
[0-9]+\.[0-9]+ { yylval.dval = atof(yytext); return DOUBLE; }
[0-9]+         { yylval.ival = atoi(yytext); return INT; }
[a-zA-Z0-9]+   {
	// we have to copy because we can't rely on yytext not changing underneath us:
	yylval.sval = strdup(yytext);
	return STRING;
}
.              ;
%%
