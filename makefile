snazzle.tab.c snazzle.tab.h: database.y
	bison -d database.y

lex.yy.c: database.l snazzle.tab.h
	flex database.l

database: lex.yy.c snazzle.tab.c snazzle.tab.h
	g++ snazzle.tab.c lex.yy.c -lfl -o database
