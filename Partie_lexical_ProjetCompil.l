%{
#include<string.h>
#include <stdio.h>
#include "Partie_syntaxique_ProjetCompil.tab.h" 
int ligne=1;
int colonne=0;
extern YYSTYPE yylval;
%}

chiffre	[0-9]
lettre [a-z]
idf ({lettre}({lettre}|_|{chiffre})*({lettre}|{chiffre}))|{lettre}
pint -([1-3]?[0-2]?[0-7]?[0-6]?[0-8])|[1-3]?[0-2]?[0-7]?[0-6]?[0-7]|"-"?[1-9]?[0-9]?[0-9]?[0-9]|0
pfloat "-"?([0-9]\.[0-9]+|[1-9]+\.[0-9]+)
comment ("//"(.)*)|("/""*"(.)*"*""/")

%%
begin {return begin;
      colonne=colonne+yyleng;}
end {return end;
      colonne=colonne+yyleng;}
code {return code;
       colonne=colonne+yyleng;}
integer {return integer;
      colonne=colonne+yyleng;}
real {return real;
      colonne=colonne+yyleng;}
WHILE { return WHILE;
      colonne=colonne+yyleng;}
FOR { return FOR;
       colonne=colonne+yyleng;}
ENDFOR { return ENDFOR;
       colonne=colonne+yyleng;}
DO { return DO;
       colonne=colonne+yyleng;}
IF {return IF;
       colonne=colonne+yyleng;}
ELSE {return ELSE;
       colonne=colonne+yyleng;}

{idf}  {if (yyleng<=12) {yylval.str=strdup(yytext);
             return idf;}
       else printf("erreur lexical :idf est trop long ");
         colonne=colonne+yyleng; }
{pint} {if (yyleng<7)  {yylval.num=atoi(yytext);
            return pint;}
        else printf("erreur lexical :valeur est fausse ");
       colonne=colonne+yyleng; }
{pfloat} {yylval.fnum=atof(yytext); 
            return pfloat;
       colonne=colonne+yyleng;}
[();|:] {return yytext[0];
       colonne=colonne+yyleng;}
{comment} { return comment ; 
       colonne=colonne+yyleng;}
"+" {return addition ;
       colonne=colonne+yyleng;}
"-" {return soustraction;
       colonne=colonne+yyleng;}
"*" {return multiplication ;
       colonne=colonne+yyleng;}
"/" {return division ;
       colonne=colonne+yyleng;}
"<--" {return aff ;
       colonne=colonne+yyleng;}
">" {return superieur ;
       colonne=colonne+yyleng;}
"<" {return inferieur;
       colonne=colonne+yyleng;}
">=" {return supouegale ;
       colonne=colonne+yyleng;}
"<=" {return infouegale ;
       colonne=colonne+yyleng;}
"!=" {return different ;
       colonne=colonne+yyleng;}
"!" {return neg ;
       colonne=colonne+yyleng;}
"&" {return etlog ;
       colonne=colonne+yyleng;}
"==" {return Egale ;
       colonne=colonne+yyleng;}

[ \t] {colonne=colonne+yyleng;}
\n {ligne++; colonne=0;}

. {printf("\nErreur lexical a ligne %d et colonne %d",ligne,colonne);}

%%
int yywrap(void)
{
return 0;
}