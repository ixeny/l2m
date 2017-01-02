%{
#define YYSTYPE char*

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "lex.yy.h"
#include "l2m.tab.h"

#define MATHO	"<math xmlns=\"http://www.w3.org/1998/Math/MathML\">"
#define MATHC	"</math>"

#define MIO	"<mi>"
#define MIC	"</mi>"

#define MOO	"<mo>"
#define MOC	"</mo>"

#define MNO	"<mn>"
#define MNC	"</mn>"

#define UOO	"<munderover>"
#define UOC	"</munderover>"

#define RTO	"<mroot>"
#define RTC	"</mroot>"

#define SQO	"<msqrt>"
#define SQC	"</mmsqrt>"

#define MFO	"<mfrac>"
#define MFC	"</mfrac>"

#define PWO	"<msup>"
#define PWC	"</msup>"

#define NFO	"<msub>"
#define NFC	"</msub>"

#define RWO	"<mrow>"
#define RWC	"</mrow>"



void yyerror(const char *s);
char str[1024];

%}

%start ligne

%token NUMBER OPERATOR IDENTIFIER ALPHA BETA UND POW
%token FRAC SQRT SUM PROD
%token DOLLAR PM INFINITY MP CAP CUP SUB SUP SUBE SUPE


%%

ligne   : DOLLAR formule DOLLAR {printf("%s\n%s\n %s %s\n%s\n", MATHO, RWO, $2,RWC, MATHC);}
	;

formule : FRAC frac formule
	| SQRT racine formule 
	| underover formule 
	| operation formule 	
	| caractere formule 
	|
	;
		
underover:SUM  UND'{'formule'}'POW'{'formule'}' {
		sprintf(str,"%s\n %s%s%s\n %s %s %s\n%s %s %s\n%s\n", UOO, MOO, $1, MOC, RWO, $4,RWC,RWO, $8, RWC, UOC);
		strcpy($$,str);}
	| PROD UND'{'formule'}'POW'{'formule'}' {
		sprintf(str,"%s\n %s%s%s\n %s %s %s\n%s %s %s\n%s\n", UOO, MOO, $1, MOC, RWO, $4,RWC,RWO, $8, RWC, UOC);
		strcpy($$,str);}
	;	

frac	: caractere caractere {sprintf(str,"%s\n %s %s %s\n", MFO, $1, $2, MFC); strcpy($$,str);}
	| '{'formule'}''{'formule'}'{sprintf(str,"%s\n %s %s %s\n", MFO, $2, $5, MFC); strcpy($$,str);}
	;

racine	: '['formule']''{'formule'}'	{sprintf(str,"%s\n %s %s %s\n",RTO, $5, $2,RTC); strcpy($$,str);}
	| '{'formule'}'			{sprintf(str,"%s\n %s %s\n",SQO, $2,SQC); strcpy($$,str);}
	;

operation:POW formule {sprintf(str,"%s%s%s\n",PWO, $2,PWC); strcpy($$,str);}
	 |UND formule {sprintf(str,"%s%s%s\n",NFO, $2,NFC); strcpy($$,str);}
	;

caractere: IDENTIFIER 	{sprintf(str,"%s%s%s\n",MIO, $1,MIC); strcpy($$,str);}
	| OPERATOR 	{sprintf(str,"%s%s%s\n",MOO, $1,MOC); strcpy($$,str);}
	| NUMBER 	{sprintf(str,"%s%s%s\n",MNO, $1,MNC); strcpy($$,str);}
	| PM 
	| MP 
	| ALPHA
	| BETA
	| INFINITY
	| CAP 
	| CUP
	| SUB 
	| SUP 
	| SUBE
	| SUPE
	| '('
	| ')'
	;
%%
