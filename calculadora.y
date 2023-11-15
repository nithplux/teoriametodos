%{
#include <stdio.h>
#include <math.h>

double variable_value = 0.0;

void set_variable(double value) {
    variable_value = value;
}

double power(double base, int exp) {
    if (exp == 0) return 1;
    if (exp == 1) return base;
    return base * power(base, exp - 1);
}

double factorial(int n) {
    if (n == 0 || n == 1) return 1;
    return n * factorial(n - 1);
}

%}

%token NUMBER
%token ADD SUB MUL DIV
%token SIN COS TAN COT
%token DERIVATIVE INTEGRAL
%token LPAREN RPAREN
%token EOL

%left '+' '-'
%left '*' '/'
%left SIN COS TAN COT
%right DERIVATIVE
%right INTEGRAL

%token <num> VAR

%type <num> expr

%%

calc: expr EOL   { printf("Resultado: %f\n", $1); }
    ;

expr: NUMBER     { $$ = $1; }
    | VAR         { $$ = variable_value; }
    | expr '+' expr   { $$ = $1 + $3; }
    | expr '-' expr   { $$ = $1 - $3; }
    | expr '*' expr   { $$ = $1 * $3; }
    | expr '/' expr   { $$ = $1 / $3; }
    | SIN expr        { $$ = sin($2); }
    | COS expr        { $$ = cos($2); }
    | TAN expr        { $$ = tan($2); }
    | COT expr        { $$ = 1.0 / tan($2); }
    | expr '^' expr   { $$ = power($1, (int)$3); }
    | LPAREN expr RPAREN { $$ = $2; }
    | DERIVATIVE expr { $$ = (variable_value + 0.000001 - $2) / 0.000001; }
    | INTEGRAL expr   { $$ = $2 * 0.000001; }
    ;

%%

int main() {
    yyparse();
    return 0;
}
