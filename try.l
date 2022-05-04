alpha [A-Za-z]
digit [0-9]

%%

[\t \n]
main				return M;
int|float|void|char		{strcpy(yylval.str,yytext); return TYPE;}
return				return RET;
printf.*\n			{strcpy(yylval.str,yytext); return PRINT;}
#.*\n				{strcpy(yylval.str,yytext); return I;}
{digit}+    			{strcpy(yylval.str,yytext); return NUM;}
{alpha}({alpha}|{digit})*	{strcpy(yylval.str,yytext);return ID;}
"<="         			return LE;
">="         			return GE;
"=="         			return EQ;
"!="         			return NE;
"||"         			return OR;
"&&"         			return AND;
,				return COMMA;
.            			return yytext[0];

%%
