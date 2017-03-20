(* File lexer.mll *)
{
	open Techno
	open Parser
	exception Eof
	exception EmptyListError

	let stream_of_channel channel =
	  Stream.from
	    (fun _ ->
	      try Some (input_line channel) with End_of_file -> None)
	;;

	let rec last_element = function
		| [x] -> x
		| _ :: t ->  last_element t
	;;

	let rm_dollar (s : string) =
		String.sub s 1 1;
	;;

	let input_file = stream_of_channel stdin;;

	let get_line (ln : string) =
	  last_element (Stream.npeek (int_of_string (rm_dollar ln)) input_file)
	;;

	let get_last_line (ln : int) =
	  int_of_string (last_element (Stream.npeek ln input_file))
	;;
}

(* Lexer symbols *)
rule lexer_main = parse
	| [' ' '\t' '\n' '\r'] 		{ lexer_main lexbuf }
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
	| '*'							{ KLEENE }
	| "$"['1'-'9']+ as lxm			{ LANGUAGE(get_line lxm) }
	| "$last_line"					{ INT(get_last_line 10) }
	| "cap"							{ CAP }
	| ";"							{ EOL }
	| ";;"							{ EOF }			(* EOL functions *)
	| "concatABC"					{ CONCATABC }
