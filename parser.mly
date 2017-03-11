/* File parser.mly */
%{
	(* TODO add that line from that other file *)
%}

%token <int> INT
%token PLUS MINUS MULTIPLY DIVIDE
%token LPAREN RPAREN
%token EOL EXPO MOD
%left PLUS MINUS
%left MULTIPLY DIVIDE
%left EXPO MOD
%nonassoc UMINUS
%start main
%type <int> main
%%
main:
		expr EOF		{ $1 }
	;
	expr:
		INT					{ $1 }
	| LPAREN expr RPAREN 	{ $2 }
	| expr PLUS expr 		{ $1 + $3 }
	| expr MINUS expr 		{ $1 - $3 }
