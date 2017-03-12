/* File parser.mly */
%{
	open Techno
%}
%token <int> INT
%token PLUS MINUS MULTIPLY DIVIDE EXPO MOD
%token LPAREN RPAREN
%token INT_TYPE BOOL_TYPE
%token EOF
%left PLUS MINUS
%left MULTIPLY DIVIDE
%left EXPO MOD
%start parser_main
%type <Techno.tech> parser_main
%type <Techno.technoType> type
%%
parser_main:
	| expr EOF					{ $1 }
;
type:
	| INT_TYPE					{ TechnoInt }
	| LPAREN type RPAREN		{ $2 }
;
expr:
	| INT						{ TNum $1 }
	| LPAREN expr RPAREN 		{ $2 }
	| expr PLUS expr 			{ TPlus($1, $3) }
	| expr MINUS expr 			{ TMinus($1, $3) }
	| expr MULTIPLY expr		{ TMultiply($1, $3) }
	| expr DIVIDE expr			{ TDivide($1, $3) }
	| expr EXPO expr			{ TExpo($1, $3) }
	| expr MOD expr				{ TMod($1, $3) }
;
