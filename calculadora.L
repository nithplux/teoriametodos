%{
#include "y.tab.h"
%}

%%
"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"sin"   { return SIN; }
"cos"   { return COS; }
"tan"   { return TAN; }
"cot"   { return COT; }
"derivative" { return DERIVATIVE; }
"integral"   { return INTEGRAL; }
"("     { return LPAREN; }
")"     { return RPAREN; }
[0-9]+  { yylval.num = atof(yytext); return NUMBER; }
\n      { return EOL; }
[ \t]   ; // Ignorar espacios en blanco y tabulaciones
.       { return yytext[0]; }
%%

