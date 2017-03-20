(* File lexer.mll *)
{
	open Parser
	open Utils
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
	| "$"['0'-'9']+ as lxm			{ LANGUAGE(nth lxm) }
	| "$last_line"					{ INT (get_last_line)}
	| ";;"							{ EOL }			(* EOL and EOF functions *)
