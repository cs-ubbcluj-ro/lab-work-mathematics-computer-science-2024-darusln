%{
#include "./parser.tab.h"
#include <stdio.h>
int yylineno = 1; // Initialize line tracking
%}

/* Regular Expressions for Tokens */
%%
"#include"          { printf("Line %d: Token: INCLUDE, Text: %s\n", yylineno, yytext); return INCLUDE; }
"using"             { printf("Line %d: Token: USING, Text: %s\n", yylineno, yytext); return USING; }
"namespace"         { printf("Line %d: Token: NAMESPACE, Text: %s\n", yylineno, yytext); return NAMESPACE; }
"int"               { printf("Line %d: Token: INT, Text: %s\n", yylineno, yytext); return INT; }
"float"             { printf("Line %d: Token: FLOAT, Text: %s\n", yylineno, yytext); return FLOAT; }
"main"              { printf("Line %d: Token: MAIN, Text: %s\n", yylineno, yytext); return MAIN; }
"struct"            { printf("Line %d: Token: STRUCT, Text: %s\n", yylineno, yytext); return STRUCT; }
"if"                { printf("Line %d: Token: IF, Text: %s\n", yylineno, yytext); return IF; }
"else"              { printf("Line %d: Token: ELSE, Text: %s\n", yylineno, yytext); return ELSE; }
"while"             { printf("Line %d: Token: WHILE, Text: %s\n", yylineno, yytext); return WHILE; }
"cin"               { printf("Line %d: Token: CIN, Text: %s\n", yylineno, yytext); return CIN; }
"cout"              { printf("Line %d: Token: COUT, Text: %s\n", yylineno, yytext); return COUT; }
"true"              { printf("Line %d: Token: TRUE, Text: %s\n", yylineno, yytext); return TRUE; }
"false"             { printf("Line %d: Token: FALSE, Text: %s\n", yylineno, yytext); return FALSE; }
"iostream"          { printf("Line %d: Token: IOSTREAM, Text: %s\n", yylineno, yytext); return IOSTREAM; }
"stdio.h"           { printf("Line %d: Token: STDIOH, Text: %s\n", yylineno, yytext); return STDIOH; }
"std"               { printf("Line %d: Token: STD, Text: %s\n", yylineno, yytext); return STD; }

"<<"                { printf("Line %d: Token: LARR, Text: %s\n", yylineno, yytext); return LARR; }
">>"                { printf("Line %d: Token: RARR, Text: %s\n", yylineno, yytext); return RARR; }
"<="                { printf("Line %d: Token: RELOP, Text: %s\n", yylineno, yytext); return RELOP; }
">="                { printf("Line %d: Token: RELOP, Text: %s\n", yylineno, yytext); return RELOP; }
"=="                { printf("Line %d: Token: RELOP, Text: %s\n", yylineno, yytext); return RELOP; }
"!="                { printf("Line %d: Token: RELOP, Text: %s\n", yylineno, yytext); return RELOP; }
"<"                 { printf("Line %d: Token: LT, Text: %s\n", yylineno, yytext); return LT; }
">"                 { printf("Line %d: Token: GT, Text: %s\n", yylineno, yytext); return GT; }
"+"                 { printf("Line %d: Token: ADDOP, Text: %s\n", yylineno, yytext); return ADDOP; }
"-"                 { printf("Line %d: Token: ADDOP, Text: %s\n", yylineno, yytext); return ADDOP; }
"*"                 { printf("Line %d: Token: MULOP, Text: %s\n", yylineno, yytext); return MULOP; }
"/"                 { printf("Line %d: Token: MULOP, Text: %s\n", yylineno, yytext); return MULOP; }
"="                 { printf("Line %d: Token: EQ, Text: %s\n", yylineno, yytext); return EQ; }

"{"                 { printf("Line %d: Token: LBRACE, Text: %s\n", yylineno, yytext); return LBRACE; }
"}"                 { printf("Line %d: Token: RBRACE, Text: %s\n", yylineno, yytext); return RBRACE; }
";"                 { printf("Line %d: Token: SEMI, Text: %s\n", yylineno, yytext); return SEMI; }
"("                 { printf("Line %d: Token: LPAREN, Text: %s\n", yylineno, yytext); return LPAREN; }
")"                 { printf("Line %d: Token: RPAREN, Text: %s\n", yylineno, yytext); return RPAREN; }
","                 { printf("Line %d: Token: COMMA, Text: %s\n", yylineno, yytext); return COMMA; }
"."                 { printf("Line %d: Token: DOT, Text: %s\n", yylineno, yytext); return DOT; }

[0-9]+              { printf("Line %d: Token: NUMBER, Text: %s\n", yylineno, yytext); yylval = atoi(yytext); return NUMBER; }
\"[^\"]*\"          { printf("Line %d: Token: STRING_LITERAL, Text: %s\n", yylineno, yytext); return STRING_LITERAL; }
[a-zA-Z_][a-zA-Z0-9_]* { printf("Line %d: Token: ID, Text: %s\n", yylineno, yytext); return ID; }

[ \t]+              ; /* Ignore whitespace */
\n                  { yylineno++; } /* Increment line number */
.                   { printf("Line %d: Unrecognized token: %s\n", yylineno, yytext); return 0; }
%%

int yywrap() { return 1; }
