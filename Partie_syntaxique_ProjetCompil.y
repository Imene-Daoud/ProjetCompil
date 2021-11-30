%{
#include<stdio.h>
extern int ligne;
extern int colonne;
int yyparse();
int yylex();
int yyerror(char *s);

%}

%union {
int num;
float fnum;
char* str;
}
%start S                
%token begin end integer real WHILE FOR ENDFOR DO IF ELSE code addition soustraction multiplication division aff neg superieur inferieur supouegale infouegale different etlog Egale ':' '|' '(' ')' ';'
%token <str> idf comment 
%token <num> pint
%token <fnum> pfloat
%%

S: entete declaration begin  corps  end  { printf ("le code syntaxiquement juste");YYACCEPT ;}
;

entete: code  idf 
;

type: integer  | real 
;

value: pfloat | pint 
;

declaration: listvar ':' type ';'  | listvar ':' type ';' declaration 
;

listvar: idf | idf A
;

A: '|'idf | '|'idf A
; 

corps: corps inst  | inst 
;

inst: affectation ';'  | boucle  | condition |affectation ';' inst  |boucle inst  |condition inst 
;

affectation: idf aff value  | idf aff exparthm 
;

boucle: FOR idf aff value WHILE value 
        DO 
        inst 
        ENDFOR 
;

condition: DO instDo ':' IF E ELSE instDo | DO instDo ':' IF E
;

instDo: affectation | inst
;

exparthm: value | idf | '(' exparthm ')' | value B | idf B | '(' exparthm ')' B
;

B: opar exparthm B | opar exparthm
;

expcomp: exparthm opcp exparthm | '(' expcomp ')' | idf opcp idf | idf opcp value
;

explog: expcomp oplog expcomp | '(' explog ')' | idf oplog idf| idf oplog value
;

E: explog | expcomp | exparthm
;

opar: addition | soustraction | multiplication | division
;

opcp: superieur | inferieur | Egale | different | supouegale | infouegale
;

oplog: etlog | '|' | neg
;


%%
int yyerror(char* msg)
{printf("%s ligne %d et colonne %d",msg,ligne,colonne);
return 0;
}

int main()  
{    
yyparse();  
return 0;  
} 
