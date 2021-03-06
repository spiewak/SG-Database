%{
#include <cstdio>
#include <iostream>
using namespace std;

#include "database.tab.h"  // to get the token types that we return

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
extern int line_num;
 
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

%token HEADER_DATA
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
%token INTERJECTION
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
%token UNIDENTIFIED_CHARACTER

// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:
%token <ival> INT
%token <dval> DOUBLE
%token <sval> VARCHAR

%%

file:
	version base
	;
version:
	HEADER_DATA DOUBLE { cout << "Database engine version: " << $2 << endl; }
	;
base:
	base table | table
	;
table:
	SLASH VARCHAR SLASH COLON columns COLON conditions LEFT_BRACE records RIGHT_BRACE
	;
columns:
	columns column | column 
	;
column:
	name 
	| COMMA name
	;
conditions:
	COLON CONSTRAINT constraints COLON 
	| COLON AUTOINCREMENT autoincrements COLON
	| COLON CONSTRAINT constraints COLON COLON AUTOINCREMENT autoincrements COLON
	|
	;
constraints:
	constraints constraint | constraint
	;
constraint:
	VARCHAR operator function
	| COMMA VARCHAR operator function
	;
autoincrements:
	autoincrements autoincrement | autoincrement
	;
autoincrement:
	VARCHAR
	| COMMA VARCHAR
	;
operator:
	EQUAL 
	| LESS_THEN
	| MORE_THEN 
	| MORE_EQUAL_THEN 
	| LESS_EQUAL_THEN
	;
function:
	VARCHAR LEFT_BRACKET arguments RIGHT_BRACKET
	;
arguments:
	arguments argument | argument
	;
argument:
	INT 
	| DOUBLE 
	| coordinate
	| COMMA INT 
	| COMMA DOUBLE 
	| COMMA coordinate
	;
name:
	VARCHAR
	| attributes VARCHAR
	;
attributes:
	attributes attribute | attribute
	;
attribute:
	HASH 
	| PERCENTAGE 
	| INTERJECTION
	;
records:
	records record 
	| record
	;
record:
	LEFT_SQUARE values RIGHT_SQUARE
	;
values:
	values value | value
	;
value:
	VARCHAR 
	| INT 
	| DOUBLE 
	| coordinate 
	| date
	| COMMA VARCHAR 
	| COMMA INT 
	| COMMA DOUBLE 
	| COMMA coordinate 
	| COMMA date
	;
date:
	INT MINUS INT MINUS INT
	;
coordinate:
	BACKSLASH DOUBLE DIRECTION COMMA DOUBLE
	
%%

int main(int argc, char **argv) {
	// open a file handle to a particular file:
	FILE *myfile = fopen(argv[1], "r");
	// make sure it's valid:
	if (!myfile) {
		cout << "I can't open a database file!" << endl;
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
	cout << "Message: " << s <<endl;
	cout << "Error occured near line: " << line_num << "." <<endl;
	// might as well halt now:
	exit(-1);
}
