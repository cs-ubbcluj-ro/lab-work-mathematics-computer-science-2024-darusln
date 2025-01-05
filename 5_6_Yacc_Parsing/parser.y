%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
extern int yylex();

extern FILE *yyin;

int last_production = 0; // To track the last production used
%}

/* Token Definitions */
%token INCLUDE USING NAMESPACE INT FLOAT MAIN STRUCT IF ELSE WHILE CIN COUT TRUE FALSE
%token ID NUMBER STRING_LITERAL LARR RARR RELOP ADDOP MULOP
%token LBRACE RBRACE SEMI EQ LPAREN RPAREN COMMA LT GT DOT
%token IOSTREAM STDIOH STD

/* Grammar Rules */
%%

program
    : decl_lib decl_nmpsc INT MAIN LPAREN RPAREN LBRACE stmt_list RBRACE {
        last_production = 1;
        printf("Production used %d\n", last_production);
        printf("Program syntactic correct\n"); 
    }
    ;

decl_lib
    : INCLUDE LT library GT decl_lib { last_production = 2; printf("Production used %d\n", last_production); }
    | /* epsilon */ { last_production = 3; printf("Production used %d\n", last_production); }
    ;

library
    : IOSTREAM { last_production = 4; printf("Production used %d\n", last_production); }
    | STDIOH { last_production = 5; printf("Production used %d\n", last_production); }
    ;

decl_nmpsc
    : USING NAMESPACE nmspc SEMI decl_nmpsc { last_production = 6; printf("Production used %d\n", last_production); }
    | /* epsilon */ { last_production = 7; printf("Production used %d\n", last_production); }
    ;

nmspc
    : STD { last_production = 8; printf("Production used %d\n", last_production); }
    ;

stmt_list
    : stmt stmt_list { last_production = 9; printf("Production used %d\n", last_production); }
    | /* epsilon */ { last_production = 12; printf("Production used %d\n", last_production); }
    ;

stmt
    : declstmt { last_production = 13; printf("Production used %d\n", last_production); }
    | simplestmt { last_production = 14; printf("Production used %d\n", last_production); }
    | structstmt { last_production = 15; printf("Production used %d\n", last_production); }
    ;

declstmt
    : type_specifier ID SEMI { last_production = 17; printf("Production used %d\n", last_production); }
    | type_specifier ID EQ expression SEMI { last_production = 18; printf("Production used %d\n", last_production); }
    | type_specifier ID COMMA id_list SEMI { last_production = 19; printf("Production used %d\n", last_production); }
    ;

id_list
    : ID { last_production = 21; printf("Production used %d\n", last_production); }
    | ID COMMA id_list { last_production = 22; printf("Production used %d\n", last_production); }
    ;

type_specifier
    : INT { last_production = 23; printf("Production used %d\n", last_production); }
    | FLOAT { last_production = 24; printf("Production used %d\n", last_production); }
    ;

simplestmt
    : assignstmt { last_production = 25; printf("Production used %d\n", last_production); }
    | iostmt { last_production = 26; printf("Production used %d\n", last_production); }
    ;

assignstmt
    : ID EQ expression SEMI { last_production = 27; printf("Production used %d\n", last_production); }
    ;

iostmt
    : CIN RARR ID SEMI { last_production = 28; printf("Production used %d\n", last_production); }
    | COUT LARR expression SEMI { last_production = 29; printf("Production used %d\n", last_production); }
    | COUT LARR STRING_LITERAL SEMI { last_production = 30; printf("Production used %d\n", last_production); }
    ;

structstmt
    : ifstmt { last_production = 31; printf("Production used %d\n", last_production); }
    | whilestmt { last_production = 32; printf("Production used %d\n", last_production); }
    ;

ifstmt
    : IF LPAREN condition RPAREN LBRACE stmt_list RBRACE {
        last_production = 33; printf("Production used %d\n", last_production);
    }
    | IF LPAREN condition RPAREN LBRACE stmt_list RBRACE ELSE LBRACE stmt_list RBRACE {
        last_production = 34; printf("Production used %d\n", last_production);
    }
    ;

whilestmt
    : WHILE LPAREN condition RPAREN LBRACE stmt_list RBRACE { last_production = 35; printf("Production used %d\n", last_production); }
    ;

expression
    : expression ADDOP term { last_production = 36; printf("Production used %d\n", last_production); }
    | term { last_production = 37; printf("Production used %d\n", last_production); }
    ;

term
    : term MULOP factor { last_production = 38; printf("Production used %d\n", last_production); }
    | factor { last_production = 39; printf("Production used %d\n", last_production); }
    ;

factor
    : LPAREN expression RPAREN { last_production = 40; printf("Production used %d\n", last_production); }
    | ID { last_production = 41; printf("Production used %d\n", last_production); }
    | constant { last_production = 42; printf("Production used %d\n", last_production); }
    ;

condition
    : expression RELOP expression { last_production = 43; printf("Production used %d\n", last_production); }
    | expression LT expression { last_production = 44; printf("Production used %d\n", last_production); }
    | expression GT expression { last_production = 45; printf("Production used %d\n", last_production); }
    ;

constant
    : int_constant { last_production = 46; printf("Production used %d\n", last_production); }
    | float_constant { last_production = 47; printf("Production used %d\n", last_production); }
    | string_constant { last_production = 48; printf("Production used %d\n", last_production); }
    | boolean_constant { last_production = 49; printf("Production used %d\n", last_production); }
    ;

int_constant
    : NUMBER { last_production = 50; printf("Production used %d\n", last_production); }
    ;

float_constant
    : NUMBER DOT NUMBER { last_production = 51; printf("Production used %d\n", last_production); }
    ;

string_constant
    : STRING_LITERAL { last_production = 52; printf("Production used %d\n", last_production); }
    ;

boolean_constant
    : TRUE { last_production = 53; printf("Production used %d\n", last_production); }
    | FALSE { last_production = 54; printf("Production used %d\n", last_production); }
    ;
%%

/* Error Handling */
void yyerror(const char *s) {
    extern int yylineno; // Line number from Flex
    fprintf(stderr, "Error at line %d: %s\n", yylineno, s);
    fprintf(stderr, "Error in production: %d\n", last_production);
}

int main(int argc, char **argv) {
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        printf("Using stdin instead of file\n");
        yyin = stdin;
    } else {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Error opening file");
            exit(EXIT_FAILURE);
        }
    }

    if (yyparse() == 0) {
        printf("Program syntactic correct\n");
    } else {
        printf("Parsing failed.\n");
    }

    fclose(yyin);
    return 0;
}
