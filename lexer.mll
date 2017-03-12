(* File lexer.mll *)
{
	open Parser
}

rule lexer_main = parse
	| [' ' '\t' '\n'] 		{ lexer_main lexbuf }
	| ['0'-'9']+ as lxm 		{ INT(int_of_string lxm) }
	| "int"		{ INT_TYPE }
	| "bool"	{ BOOL_TYPE}

	| '+'		{ PLUS }
    | '-'		{ MINUS }
    | '*'		{ MULTIPLY }
    | '/'		{ DIVIDE }
    | '('		{ LPAREN }
    | ')'		{ RPAREN }
    | '^'		{ EXPO }
    | '%'		{ MOD }

	| eof		{ EOF }
