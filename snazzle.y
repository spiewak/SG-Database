%{
#include <cstdio>
#include <iostream>
using namespace std;

#include "snazzle.tab.h"  // to get the token types that we return

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
void yyerror(const char *s);
%}

// Bison fundamentally works by asking flex to get the next token, which it
// returns as an object of type "yystype".  But tokens could be of any
// arbitrary data type!  So we deal with that in Bison by defining a C union
// holding each of the types of tokens that Flex could return, and have Bison
// use that union instead of "int" for the definition of "yystype":
%union {
	int ival;
	double dval;
	char *sval;
}

// define the constant-string tokens:
%token SNAZZLE TYPE
%token END
%token DIRECTION
%token SLASH
%token COLON
%token LEFT_BRACE
%token RIGHT_BRACE
%token LEFT_SQUARE
%token RIGHT_SQUARE
%token COMMA
%token HASH
%token PERCENTAGE
%token INTRJECTION
%token EQUAL
%token LESS_THEN
%token MORE_THEN
%token MORE_EQUAL_THEN
%token LESS_EQUAL_THEN
%token CONSTRAINT
%token AUTOINCREMENT
%token BACKSLASH
%token LEFT_BRACKET
%token RIGHT_BRACKET
%token MINUS

// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:
%token <ival> INT
%token <dval> DOUBLE
%token <sval> VARCHAR

%%

// the first rule defined is the highest-level rule, which in our
// case is just the concept of a whole "snazzle file":
/*snazzle:
	header template body_section footer { cout << "done with a snazzle file!" << endl; }
	;
header:
	SNAZZLE DOUBLE { cout << "reading a snazzle file version " << $2 << endl; }
	;
template:
	typelines
	;
typelines:
	typelines typeline
	| typeline
	;
typeline:
	TYPE VARCHAR { cout << "new defined snazzle type: " << $2 << endl; }
	;
body_section:
	body_lines
	;
body_lines:
	body_lines body_line
	| body_line
	;
body_line:
	INT INT INT INT VARCHAR COMMA HASH { cout << "new snazzle: " << $1 << $2 << $3 << $4 << $5 << endl; }
	;
footer:
	END
	;
*/

base:
	table
	;
table:
	SLASH VARCHAR SLASH column LEFT_BRACE record RIGHT_BRACE
	;
column:
	COLON VARCHAR COLON
	;
record:
	LEFT_SQUARE VARCHAR RIGHT_SQUARE
	;
	
%%

main() {
	// open a file handle to a particular file:
	FILE *myfile = fopen("example.in", "r");
	// make sure it's valid:
	if (!myfile) {
		cout << "I can't open a.snazzle.file!" << endl;
		return -1;
	}
	// set flex to read from it instead of defaulting to STDIN:
	yyin = myfile;

	// parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));
	
}

void yyerror(const char *s) {
	cout << "EEK, parse error!  Message: " << s << endl;
	// might as well halt now:
	exit(-1);
}
