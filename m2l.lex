%{
#define YYSTYPE char*

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "m2l.tab.h"

%}
DIGIT [0-9]
NUMBER {DIGIT}*|{DIGIT}*"."{DIGIT}*
IDENTIFIER [a-zA-Z]
OPERATOR [+\-/*]

%%

\$ 	return DOLLAR;

{NUMBER} { yylval = strdup(yytext); return NUMBER;}

{OPERATOR} {yylval = strdup(yytext); return OPERATOR;}

{IDENTIFIER} {yylval = strdup(yytext); return IDENTIFIER;}

\\frac	{yylval = strdup(yytext); return FRAC;}

\\alpha	{yylval = strdup("&alpha;"); return ALPHA;}

\\beta	{yylval = strdup("&beta;"); return BETA;}

\_ 	return INF;

\^ 	return POW;

\\sum	{yylval = strdup("&Sum;");
	return SUM;
	}
\\prod	{yylval = strdup("&prod;");
	return PROD;
	}

\\sqrt	{yylval = strdup(yytext); return SQRT;}

\\pm	{yylval = strdup("<mo> &plusmn; </mo>");return PM;}

\\mp	{yylval = strdup("<mo> &#x2213; </mo>");return MP;}

\\infty	{yylval = strdup("&infin;"); return INFINITY;}

\\cap	{yylval = strdup("&cap;"); return CAP;}
\\cup	{yylval = strdup("&cup;"); return CUP;}
\\subset {yylval = strdup("&sub;"); return SUB;}
\\supset {yylval = strdup("&sup;"); return SUP;}
\\subseteq {yylval = strdup("&sube;"); return SUBE;}
\\supseteq {yylval = strdup("&supe;"); return SUPE;}


\[	return '[';
\]	return ']';

\{	return '{';
\}	return '}';

\(	return '(';
\)	return ')';

\n	return '\n';

. {}
%%

