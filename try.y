%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern FILE *yyin;
extern FILE *yyout;
int i = 0;
char keyword[50][50] = {"if","case","auto","const","char","default","do","double","else","enum", "extern","float","for","goto", "if","int","long","register","short","signed", "sizeof","static", "struct", "switch", "typedef", "union", "unsigned","volatile","void", "while", "continue", "break", "return"};
void yyerror(char *s);
%}
%token <str> ID NUM LE GE EQ NE OR AND TYPE I M COMMA RET PRINT
%right "="
%left OR AND
%left '>' '<' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '!'

%union
{
	char str[100];
}
%type <str> E
%type <str> ST 
%type <str> SBLOCK PROGRAM varlist
%%

PROGRAM		:SBLOCK				{printf("input accpted\n");exit(0);}
		;

SBLOCK		:ST SBLOCK
		|RET NUM ';'
		|	
		;

ST      	:PRINT
		|E ';'
		|TYPE M '(' ')' '{' SBLOCK '}'      
		|I
		|TYPE varlist ';'
        	;

varlist		:varlist COMMA ID 	{for(i=0;i<32;i++){if(strcmp(keyword[i],$3) == 0){printf("invalid syntax..");exit(0);}}}
		|ID			{for(i=0;i<32;i++){if(strcmp(keyword[i],$1) == 0){printf("invalid syntax..");exit(0);}}}
		|varlist COMMA ID'='NUM	{for(i=0;i<32;i++){if(strcmp(keyword[i],$3) == 0){printf("invalid syntax..");exit(0);}}}
		|varlist COMMA ID'='ID	{for(i=0;i<32;i++){if(strcmp(keyword[i],$3) == 0 || strcmp(keyword[i],$5) ){printf("invalid syntax..");exit(0);}}}
		|ID '=' ID 	{for(i=0;i<32;i++){if(strcmp(keyword[i],$3) == 0 || strcmp(keyword[i],$5) ){printf("invalid syntax..");exit(0);}}}		
		|ID '=' NUM 		{for(i=0;i<32;i++){if(strcmp(keyword[i],$1) == 0){printf("invalid syntax..");exit(0);}}}
		|ID '[' NUM ']' ';'	{for(i=0;i<32;i++){if(strcmp(keyword[i],$1) == 0){printf("invalid syntax..");exit(0);}}}
		;


E        	: ID '=' E {for(i=0;i<32;i++){if(strcmp(keyword[i],$1) == 0){printf("invalid syntax..");exit(0);}}}
          	| E '+' E
          	| E '-' E 
          	| E '*' E 
          	| E '/' E
          	| E '<' E
          	| E '>' E
          	| E LE E 
          	| E GE E 
          	| E EQ E 
          	| E NE E 
          	| E OR E 
          	| E AND E
          	| E '+' '+'
          	| E '-' '-'
          	| ID 	{for(i=0;i<32;i++){if(strcmp(keyword[i],$1) == 0){printf("invalid syntax..");exit(0);}}}
          	| NUM
          	;

 
%%

#include "lex.yy.c"

void yyerror(char *s)
{
    printf("\nError: %s\n",s);
}
int main() {

   	yyin=fopen("inp","r+");\
	if(yyin==NULL)
	{
		printf("\n Error ! \n");
	}
	else 
	{
		//fprintf(yyout,"#include <stdio.h>\n#include<stdlib.h>\n\nint main(){\n");	
	    	yyparse();
	}
    	//printf("var_exp%d=%s",count++,exp); 
    	return 0;
}      
