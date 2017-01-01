
LEX=flex
YACC=bison
CC=gcc
CFLAGS=-std=c99 -pedantic -Wall
LDFLAGS=-lfl -lm
LFLAGS=-D_POSIX_SOURCE -DYY_NO_INPUT --nounput

m2l: lex.yy.o m2l.tab.o
	$(CC) $+ -o $@ $(LDFLAGS)

lex.yy.c: m2l.lex m2l.tab.h
	$(LEX) $(LFLAGS) $<

lex.yy.h: m2l.lex
	$(LEX) --header-file=$@ $(LFLAGS) $<

m2l.tab.c m2l.tab.h: m2l.y lex.yy.h
	$(YACC) $< -d

%.o: %.c
	$(CC) $(CFLAGS) $< -c

clean:
	-rm m2l *.o lex.yy.* m2l.tab.*
