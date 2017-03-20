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
%token EMPTYWORD IDENT
%token DELIM
%token EOF EOL
%token CAP KLEENE CONCATABC
/* Highest precedence */
%left EOL
%nonassoc LENGTH
%nonassoc CONCAT APPENDTOLIST
%nonassoc UNION INTERSECT CAP
/* Lowest precedece */
%start parser_main
%type <Techno.tech> parser_main
%%
parser_main:
	| expr EOF										{ $1 }
;
expr:
	| expr EOL expr									{ Eol($1, $3) } 
	| INT											{ TInt $1 }
	| LANGUAGE										{ TLang $1 }
	| STRING										{ TString $1 }
	| LPAREN expr RPAREN 							{ $2 }
	| expr UNION expr 								{ TUnion($1, $3) }
	| expr INTERSECT expr							{ TIntersection($1, $3) }
	| expr CONCAT expr								{ TConcat($1, $3) }
	| LENGTH LPAREN expr RPAREN						{ TStrLen $3 }
	| APPENDTOLIST LPAREN expr DELIM expr RPAREN	{ TAppendToList($3,$5) }
	| CAP LPAREN expr DELIM expr RPAREN				{ TCap($3, $5) }
	| KLEENE LPAREN expr DELIM expr DELIM expr RPAREN	{ TKleene($3, $5, $7) }
	| CONCATABC LPAREN expr DELIM expr RPAREN		{ TConcatABC($3, $5) }
;
