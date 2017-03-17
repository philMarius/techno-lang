(* File lexer.mll *)
{
	open Parser
	exception Eof
}
(* Rules: plus, minus, multiply, divide, expo, mod *)
rule lexer_main = parse
	| [' ' '\t' '\n'] 		{ lexer_main lexbuf }
	| ['0'-'9']+ as lxm 	{ INT(int_of_string lxm) }
	| '{'(' '*(['a'-'z']+|':')' '*','' '*)*(['a'-'z']+|':')?' '*'}' as lxm		{ LANGUAGE(lxm) }
	| (' '*(['a'-'z']+|'_')' '*','' '*)*(['a'-'z']+|'_')?' as lxm		{ LANGUAGE(lxm) }
	| "int"					{ INT_TYPE }
	| "bool"				{ BOOL_TYPE }
	| "true"				{ TRUE }
	| "false" 				{ FALSE }
	| '+'					{ PLUS }		(* Maths functions *)
    | '-'					{ MINUS }
    | '*'					{ MULTIPLY }
    | '/'					{ DIVIDE }
    | '('					{ LPAREN }
    | ')'					{ RPAREN }
    | '^'					{ EXPO }
    | '%'					{ MOD }
	| 'U'					{ UNION }
	| ';'					{ EOL }			(* EOL and EOF functions *)
	| eof					{ raise Eof }
