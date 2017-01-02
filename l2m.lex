%{
#define YYSTYPE char*

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "l2m.tab.h"

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

\_ 	return UND;

\^ 	return POW;

\\sum	{yylval = strdup("&Sum;");return SUM;}
\\prod	{yylval = strdup("&prod;");return PROD;}

\\sqrt	{yylval = strdup(yytext); return SQRT;}

\\pm	{yylval = strdup("<mo> &plusmn; </mo>");return PM;}

\\mp	{yylval = strdup("<mo> &#x2213; </mo>");return MP;}

\\infty	{yylval = strdup("&infin;"); return INFINITY;}

\\cap	{yylval = strdup("<mo> &cap; </mo>"); return CAP;}
\\cup	{yylval = strdup("<mo> &cup; </mo>"); return CUP;}
\\subset {yylval = strdup("<mo> &sub; </mo>"); return SUB;}
\\supset {yylval = strdup("<mo> &sup; </mo>"); return SUP;}
\\subseteq {yylval = strdup("<mo> &sube; </mo>"); return SUBE;}
\\supseteq {yylval = strdup("<mo> &supe; </mo>"); return SUPE;}


\[	return '[';
\]	return ']';

\{	return '{';
\}	return '}';

\(	return '(';
\)	return ')';

\n	return '\n';

. {}
%%
void yyerror(const char *s) {
	fprintf(stderr,"%s\n", s);
}


int main(int argc, char** argv) {
	if (argc != 2) {
		fprintf(stderr, "Mettez en argument le flux contenant la formule LaTeX\n");
		exit(1);
	}
	yy_scan_string(argv[1]);
	yyparse();	
	return 0;
}







