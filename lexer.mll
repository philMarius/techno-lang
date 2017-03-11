(* File lexer.mll *)
{
	(* TODO add "open Parser" *)
}

rule lexer_main = parse
	[' ' '\t' '\n'] 		{ lexer_main lexbuf } 	(* skips blanks *)
	| ['0'-'9'] as lxm 		{ INT(int_of_string lxm) }
	| "int"		{ INT }

	| '+'		{ PLUS }
    | '-'		{ MINUS }
    | '*'		{ MULTIPLY }
    | '/'		{ DIVIDE }
    | '('		{ LPAREN }
    | ')'		{ RPAREN }
    | '^'		{ EXPO }
    | '%'		{ MOD }
	| eof		{ EOF }
