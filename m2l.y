%{
#define YYSTYPE char*

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "lex.yy.h"
#include "m2l.tab.h"

#define MATHO	"<math xmlns=\"http://www.w3.org/1998/Math/MathML\">"
#define MATHC	"</math>"

#define MIO		"<mi>"
#define MIC		"</mi>"

#define MOO		"<mo>"
#define MOC		"</mo>"

#define MNO		"<mn>"
#define MNC		"</mn>"

#define UOO		"<munderover>"
#define UOC		"</munderover>"

#define RTO		"<mroot>"
#define RTC		"</mroot>"

#define SQO		"<msqrt>"
#define SQC		"</mmsqrt>"

#define MFO		"<mfrac>"
#define MFC		"</mfrac>"

void yyerror(const char *s);
char str[1024];

%}

%start ligne

%token NUMBER OPERATOR IDENTIFIER ALPHA BETA INF SUP
%token FRAC SQRT SUM PROD
%token DOLLAR PM INFINITY MP CAP CUP

%%

ligne   : ligne formule '\n'{printf("%s\n<mrow>\n %s </mrow>\n%s\n",MATHO,$2,MATHC);}
	| ligne '\n'
	|
	;

formule : frac
	| SQRT racine
	| underover INF'{'formule'}'SUP'{'formule'}' {
		sprintf(str,"%s\n %s%s%s\n <mrow> %s </mrow>\n<mrow> %s </mrow>\n%s\n",UOO,MOO,$2, MOC, $5, $9,UOC);
		strcpy($$,str);}	
	| terminal
	;
		
underover: SUM  {$$=$1;}
	|  PROD {$$=$1;}
	;	

frac	: FRAC '{'formule'}''{'formule'}'{sprintf(str,"%s\n %s %s %s\n", MFO, $3, $6, MFC); strcpy($$,str);}
	;

racine	: '['formule']''{'formule'}'	{sprintf(str,"%s\n %s %s %s\n",RTO, $5, $2,RTC); strcpy($$,str);}
	| '{'formule'}'			{sprintf(str,"%s\n %s %s\n",SQO, $2,SQC); strcpy($$,str);}
	;

terminal: IDENTIFIER 	{sprintf(str,"%s%s%s\n",MIO, $1,MIC); strcpy($$,str);}
	| OPERATOR 	{sprintf(str,"%s%s%s\n",MOO, $1,MOC); strcpy($$,str);}
	| NUMBER 	{sprintf(str,"%s%s%s\n",MNO, $1,MNC); strcpy($$,str);}
	| PM 
	| ALPHA
	| BETA
	| INFINITY
	| MP 
	| CAP 
	| CUP
	;



%%


void yyerror(const char *s) {
	fprintf(stderr,"%s\n", s);
}
int main(void) {
	yyparse();
}
