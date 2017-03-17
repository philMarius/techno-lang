(* File lexer.mll *)
{
	open Parser
	exception Eof
}
(* Rules: plus, minus, multiply, divide, expo, mod *)
rule lexer_main = parse
	| [' ' '\t' '\n'] 		{ lexer_main lexbuf }
	| '{'(' '*(['a'-'z']+|':')' '*','' '*)*(['a'-'z']+|':')?' '*'}' as lxm		{ LANGUAGE(lxm) }
    | '('					{ LPAREN }
    | ')'					{ RPAREN }
	| 'U'					{ UNION }
	| ';'					{ EOL }			(* EOL and EOF functions *)
	| eof					{ raise Eof }
