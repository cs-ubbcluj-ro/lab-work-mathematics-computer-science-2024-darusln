%{
    #include <string.h>

    typedef struct {
        char token[257];
        int symbolTableCode;
    }ProgramInternalForm;

    typedef struct {
        char token[257];
        int index;
    }SymbolTable;
    
    SymbolTable ST[100];
    int stLength = 0;
 
    ProgramInternalForm PIF[300];
    int pifLength = 0;

    int errorFound = 0;
    int lineNumber = 1;

    int addToST(char* token) {
        for (int i = 0; i < stLength; i++)
        {
            if(strcmp(ST[i].token, token) == 0){
                return ST[i].index;
            }
        }
        strcpy(ST[stLength].token, token);
	    ST[stLength].index = stLength;
	    stLength++;
	
	    return stLength - 1;
    }

    void addToPIF(char* token, int stCode) {
        strcpy(PIF[pifLength].token, token);
        PIF[pifLength].symbolTableCode = stCode;
        
        pifLength++;
    }

    void showSymbolTable() {
        printf("~~~~~~~ Symbol table ~~~~~~~\n");
        
        for(int i = 0 ; i < stLength; i++) {
            printf(" %s  %d", ST[i].token, ST[i].index);
            printf("\n");
        }
        
        printf("~~~~~~~ End ST ~~~~~~~\n");
        printf("\n");
    }

    void showProgramInternalForm() {
        printf("~~~~~~~ Program internal form ~~~~~~~\n");
        
        for(int i = 0; i < pifLength; i++) {
        
            printf(" %s  %d ", PIF[i].token, PIF[i].symbolTableCode);
            printf("\n");
        }
        
        printf("~~~~~~~ End PIF ~~~~~~~\n");
        printf("\n");
    }
%}

LETTER          [A-Za-z]
ID              [a-z][a-z0-9_]*
INT_CONST       [+-]?(0|[1-9][0-9]*)
FLOAT_CONST     [+-]?(0|[1-9][0-9]*)(\.[0-9]+)?
STRING_CONST    \".*\"
WS              [ \t]+
NEWLINE         \n

%%

int           { addToPIF(yytext, -1); }
float         { addToPIF(yytext, -1); }
string        { addToPIF(yytext, -1); }
struct        { addToPIF(yytext, -1); }
if            { addToPIF(yytext, -1); }
else          { addToPIF(yytext, -1); }
while         { addToPIF(yytext, -1); }
for           { addToPIF(yytext, -1); }
cin           { addToPIF(yytext, -1); }
cout          { addToPIF(yytext, -1); }
include       { addToPIF(yytext, -1); }
using         { addToPIF(yytext, -1); }
namespace     { addToPIF(yytext, -1); }
std           { addToPIF(yytext, -1); }


\#             { addToPIF(yytext, -1); }
#[^\n]*        { addToPIF(yytext, -1); }
\+             { addToPIF(yytext, -1); }
\-             { addToPIF(yytext, -1); }
\*             { addToPIF(yytext, -1); }
\/             { addToPIF(yytext, -1); }
\=             { addToPIF(yytext, -1); }
\==            { addToPIF(yytext, -1); }
\!=            { addToPIF(yytext, -1); }
\<             { addToPIF(yytext, -1); }
\>             { addToPIF(yytext, -1); }
\<=            { addToPIF(yytext, -1); }
\>=            { addToPIF(yytext, -1); }

\(             { addToPIF(yytext, -1); }
\)             { addToPIF(yytext, -1); }
\{             { addToPIF(yytext, -1); }
\}             { addToPIF(yytext, -1); }
\[             { addToPIF(yytext, -1); }
\]             { addToPIF(yytext, -1); }
\,             { addToPIF(yytext, -1); }
\;             { addToPIF(yytext, -1); }

{ID}           { int stCode = addToST(yytext); addToPIF(yytext, stCode); }
{INT_CONST}    { int stCode = addToST(yytext); addToPIF(yytext, stCode); }
{FLOAT_CONST}  { int stCode = addToST(yytext); addToPIF(yytext, stCode); }
{STRING_CONST} { int stCode = addToST(yytext); addToPIF(yytext, stCode); }

[\n]		   { ++lineNumber; }
[ \t\n]+       { ; }
.              { errorFound = 1; printf("Illegal token %s at line %d !", yytext, lineNumber); printf("\n"); }
%%

int yywrap() {}

int main(int argc, char** argv) {

	FILE *fp;
	fp = fopen(argv[1], "r");
	
	/* yyin - takes the file pointer which contains the input*/
	yyin = fp;

	/* yylex() - this is the main flex function which runs the Rule Section*/ 
	yylex();
	
	if (errorFound == 0) {
    		showSymbolTable();
    		showProgramInternalForm();
	}
  
	return 0;
}
