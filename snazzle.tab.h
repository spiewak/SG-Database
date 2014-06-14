/* A Bison parser, made by GNU Bison 2.5.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2011 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     SNAZZLE = 258,
     TYPE = 259,
     END = 260,
     DIRECTION = 261,
     SLASH = 262,
     COLON = 263,
     LEFT_BRACE = 264,
     RIGHT_BRACE = 265,
     LEFT_SQUARE = 266,
     RIGHT_SQUARE = 267,
     COMMA = 268,
     HASH = 269,
     PERCENTAGE = 270,
     INTERJECTION = 271,
     EQUAL = 272,
     LESS_THEN = 273,
     MORE_THEN = 274,
     MORE_EQUAL_THEN = 275,
     LESS_EQUAL_THEN = 276,
     CONSTRAINT = 277,
     AUTOINCREMENT = 278,
     BACKSLASH = 279,
     LEFT_BRACKET = 280,
     RIGHT_BRACKET = 281,
     MINUS = 282,
     HEADER_DATA = 283,
     INT = 284,
     DOUBLE = 285,
     VARCHAR = 286
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 2068 of yacc.c  */
#line 21 "snazzle.y"

	int ival;
	double dval;
	char *sval;



/* Line 2068 of yacc.c  */
#line 89 "snazzle.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


