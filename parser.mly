/* File parser.mly */
%{
	open Techno
%}
%token <string> LANGUAGE
%token LPAREN RPAREN
%token STRING DELIM
%token UNION
%token LSETPAREN RSETPAREN
%token EOF EOL
%start parser_main
%type <Techno.tech> parser_main
%%
parser_main:
	| expr EOL					{ $1 }
;
expr:
	| LANGUAGE						{ TLang $1 }
	| LPAREN expr RPAREN 			{ $2 }
	| expr UNION expr				{ TUnion($1, $3) }
;
