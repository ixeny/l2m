
LEX=flex
YACC=bison
CC=gcc
CFLAGS=-std=c99 -pedantic -Wall
LDFLAGS=-lfl -lm
LFLAGS=-D_POSIX_SOURCE -DYY_NO_INPUT --nounput

l2m: lex.yy.o l2m.tab.o
	$(CC) $+ -o $@ $(LDFLAGS)

lex.yy.c: l2m.lex l2m.tab.h
	$(LEX) $(LFLAGS) $<

lex.yy.h: l2m.lex
	$(LEX) --header-file=$@ $(LFLAGS) $<

l2m.tab.c l2m.tab.h: l2m.y lex.yy.h
	$(YACC) $< -d

%.o: %.c
	$(CC) $(CFLAGS) $< -c

clean:
	-rm l2m *.o lex.yy.* l2m.tab.*
