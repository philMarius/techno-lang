/* File parser.mly */
%{
	open Techno
%}
%token <int> INT
%token <string> STRING
%token PLUS MINUS MULTIPLY DIVIDE EXPO MOD
%token LPAREN RPAREN
%token STRING DELIM
%token UNION
%token LSETPAREN RSETPAREN
%token INT_TYPE BOOL_TYPE
%token TRUE FALSE
%token EOF EOL
%left PLUS MINUS
%left MULTIPLY DIVIDE
%left EXPO MOD
%start parser_main
%type <Techno.tech> parser_main
%type <Techno.technoType> type
%%
parser_main:
	| expr EOL					{ $1 }
;
type:
 	| INT_TYPE					{ TechnoInt }
	| BOOL_TYPE					{ TechnoBool }
	| LPAREN type RPAREN		{ $2 }
;
expr:
	| INT							{ TNum $1 }
	| TRUE							{ TBool true }
	| STRING						{ TString $1 }
	| LSETPAREN set_type RSETPAREN	{ TSet $2 }
	| FALSE							{ TBool false }
	| LPAREN expr RPAREN 			{ $2 }
	| expr PLUS expr 				{ TPlus($1, $3) }
	| expr MINUS expr 				{ TMinus($1, $3) }
	| expr MULTIPLY expr			{ TMultiply($1, $3) }
	| expr DIVIDE expr				{ TDivide($1, $3) }
	| expr EXPO expr				{ TExpo($1, $3) }
	| expr MOD expr					{ TMod($1, $3) }
	| expr UNION expr				{ TUnion($1, $3) }
;
set_type:
	| expr DELIM set_type			{ TLinkSet($1, $3) }
	| expr							{ TValue($1) }
;
