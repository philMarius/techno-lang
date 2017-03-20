/* File parser.mly */
%{
	open Techno
%}
%token <string> LANGUAGE
%token <string> STRING
%token <int> INT
%token CONCAT LENGTH APPENDTOLIST
%token LPAREN RPAREN
%token UNION INTERSECT
%token EMPTYWORD
%token DELIM
%token EOL
/* Highest precedence */
%nonassoc LENGTH
%nonassoc CONCAT APPENDTOLIST
%nonassoc UNION INTERSECT
/* Lowest precedece */
%start parser_main
%type <Techno.tech> parser_main
%%
parser_main:
	| expr EOL										{ $1 }
;
expr:
	| INT											{ TInt $1 }
	| LANGUAGE										{ TLang $1 }
	| STRING										{ TString $1 }
	| LPAREN expr RPAREN 							{ $2 }
	| expr UNION expr 								{ TUnion($1, $3) }
	| expr INTERSECT expr							{ TIntersection($1, $3) }
	| expr CONCAT expr								{ TConcat($1, $3) }
	| LENGTH LPAREN expr RPAREN						{ TStrLen $3 }
	| APPENDTOLIST expr expr						{ TAppendToList($2,$3) }
;
