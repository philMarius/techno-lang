/* File parser.mly */
%{
	open Techno
%}

%token <int> INT
%token PLUS MINUS MULTIPLY DIVIDE
%token LPAREN RPAREN
%token EOF EXPO MOD
%token INT_TYPE BOOL_TYPE
%left PLUS MINUS
%left MULTIPLY DIVIDE
%left EXPO MOD
%nonassoc UMINUS
%start parser_main
%type <Techno.tech> parser_main
%type <Techno.technoType> type
%%
parser_main:
	| expr EOF					{ $1 }
;
type:
	| INT_TYPE					{ TechnoInt }
	| BOOL_TYPE					{ TechnoBool }
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
	| expr EOF 					{ $1 }
;
