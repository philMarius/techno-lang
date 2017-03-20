(* File lexer.mll *)
{
	open Parser
	exception Eof
}
(* Lexer symbols *)
rule lexer_main = parse
	| [' ' '\t' '\n'] 		{ lexer_main lexbuf }
	| '{'(' '*(['a'-'z']+|':')' '*','+' '*)*(['a'-'z']+|':')?' '*'}' as lxm {LANGUAGE(lxm) }
	| ('"'(['a'-'z''A'-'Z''0'-'9']|' '|','|'.')*'"')|'_' as lxm		{ STRING(lxm) }
	| ['0'-'9']+ as lxm				{ INT(int_of_string lxm) }
    | '('							{ LPAREN }
    | ')'							{ RPAREN }
	| 'U'							{ UNION }
	| 'N'							{ INTERSECT }
	| '.'							{ CONCAT }
	| "strlen"						{ LENGTH }
	| "prefixToList"				{ APPENDTOLIST }
	| ','							{ DELIM }
	| ':'							{ EMPTYWORD }
	| ";;"							{ EOL }			(* EOL and EOF functions *)
