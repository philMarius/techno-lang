(* File Techno.ml *)

exception LookupError ;;
exception TypeError of string;;
exception Terminated ;;
exception InvalidNumberException ;;
exception NonBaseTypeResult ;;
exception StuckTerm ;;

open Printf;;
open Str;;

(*==== Types of the Techno language ====*)
type technoType =
	| TechnoLang
	| TechnoString
	| TechnoInt

(*==== Grammar of the Techno language ====*)
type tech =
	| TInt of int
	| TLang of string
	| TUnion of tech * tech
	| Eol of tech * tech
	| TIntersection of tech * tech
	| TString of string
	| TConcat of tech * tech
	| TStrLen of tech
	| TAppendToList of tech * tech
	| TCap of tech * tech
	| TKleene of tech * tech
	| TConcatABC of tech * tech
	| TPostfixToList of tech * tech

let rec isValue e =
	match e with
		| TLang (x) -> true
		| TString (s) -> true
		| TInt (n) -> true
		| _ -> false
;;

open Str;;

(*==== Utilities functions ====*)

(* Append to end of a list *)
let append l1 l2 =
	let rec aux l3 = function
		| [] -> l3
		| ':'::t -> aux l3 t
		| h::t -> aux (h::l3) t in
	aux l1 l2
;;

(* Remove the right curly braces *)
let rm_rparen s =
	Str.global_replace (Str.regexp "{") "" s
;;

(* Remove the left curly braces *)
let rm_lparen s =
	Str.global_replace (Str.regexp "}") "" s
;;

(* Sort and remove duplicates *)
let uniq_sort l =
	let sort = List.sort compare l in
	let rec aux l2 = function
		| [] -> List.rev l2
		| h :: t -> if (List.mem h l2) then aux l2 t else aux (h :: l2) t
	in List.sort compare (aux [] sort)
;;

let alphabet l1 =
	List.sort String.compare l1;;

let rm_quotes s =
	String.sub s 1 ((String.length s) - 2);;

let destring x = if (String.contains x '\"') then (rm_quotes x) else x;;

let appender list letter =
	let rec aux acc = function
		| [] -> acc
		| ":" :: t -> aux (letter :: acc) t
		| h::t -> aux ((letter^h)::acc) t in
	aux [] list;;

let postfixer n list =
	let rec aux acc = function
		| [] -> acc
		| ":" :: t -> aux acc t
		| h :: t -> aux ((h^(destring n)) :: acc) t in
	aux [] list;;

let removeDuplicates l1 = 
		let rec aux l2 = function
			| [] -> List.rev l2
			| h :: t -> if List.mem h l2 then aux l2 t else aux (h :: l2) t
	in aux [] l1;;

let rm_spaces s =
	Str.global_replace (Str.regexp " ") "" s;;

(* Convert string form of set to list *)
let str_to_lst str =
	let rm_paren str =
		String.sub str 1 ((String.length str) - 2)
	in alphabet (Str.split (Str.regexp ",") (rm_paren (rm_spaces str)))
;;

(* Different union function *)
let union l1 l2 =
	uniq_sort (List.merge compare l1 l2)
;;

(* Intersection of two sets *)
let rec intersect l1 l2 =
		match l1 with [] -> []
				| h1::t1 -> (
					match l2 with
							| [] -> []
							| h2::t2 when h1 < h2 -> intersect t1 l2
							| h2::t2 when h1 > h2 -> intersect l1 t2
							| h2::t2 -> (
								match intersect t1 t2 with
										| [] -> [h1]
										| h3::t3 as l when h3 = h1 -> l
										| h3::t3 as l -> h1::l
							)
				);;

(* Convert list to string form of set *)
let lst_to_str l =
	"{"^(String.concat "," l)^"}"
;;

(* Add quotes back to the string *)
let add_quotes s =
	"\""^s^"\""
;;

(* Generate string of length l comprised of string n    --> Use String.make *)
let string_repeat n s =
	String.concat "" (Array.to_list (Array.make n (destring s)));;

(* Generate list of length n of singleton list l1 of letter s *)
let kleene n l1 s =
	let rec aux x l2 = function
		| [] -> l2
		| h::t -> if x < n then aux (x+1) ((h^(string_repeat x (rm_quotes s))) :: l2) l1 else List.rev l2
	in aux 0 [] l1
;;

(* Take letter n and concatenate it with every element in list l2 *)
let append_letter_to_list n l2 =
	let rec aux l3 = function
		| [] -> List.rev l3
		| ":" :: t -> aux ((destring n) :: l3) t
		| h::t -> aux (((destring n)^h)::l3) t
	in aux [] l2;;

let addLetter n l2 =
	let rec aux l3 = function
	| [] -> List.rev l3
	| h::t -> aux ((n^h)::l3) t 
	in aux [] l2;;

(* Limit length of list l1 to length n *)
let limit_list_length n l1 =
	let rec aux x l2 = function
		| [] -> l2
		| h :: t -> if x = 0 then List.rev l2 else aux (x - 1) (h :: l2) t
	in aux n [] l1
;;

let limitLength n l1 =
	let rec aux x l2 = function
		| [] -> l2
		| h :: t -> if x < n then aux (x + 1) (h :: l2) t else List.rev l2
	in aux 0 [] l1;;

let rec cap i l =
	match (i, l) with
	| 0, h :: t -> []
	| _, [] -> l
	| _, h :: t-> h :: cap (i - 1) t
;;

let appenderMaster n l1 =
	removeDuplicates ( alphabet ( appender l1 (destring n)));;

let postfixToList n l1 =
	removeDuplicates (alphabet (postfixer (destring n) l1));;

let sort_uniq_limit n l1 = 
	limitLength n (removeDuplicates (alphabet l1));;

let sort_uniq l1 =
	removeDuplicates (alphabet l1);;

let concatModular n l1 l2=
	let rec aux = function
		| [] -> []
		| h :: t -> limitLength n (addLetter h l2)
	in aux l1;;

let concat l1 l2 =
	let rec aux l3 = function
		| [] -> l3
		| h :: t -> aux (union (appender l2 h) l3) t in
aux [] l1;;

let concatMaster n l1 =
	let rec aux x l3 = 
		if x < n then aux (x+1) (concat l1 l3) else l3
in aux 1 l1;;

let kleeneIndividual n s=
	let rec aux x l2 =
		if x < n 
		then aux (x+1) ((string_repeat x s) :: l2) 
		else List.rev l2
in aux 0 [];;

(*==== Type checking function ====*)
let rec typeOf e =
	match e with
		| TInt(n) -> TechnoInt
		| TLang(e1) -> TechnoLang
		| TString(s) -> TechnoString
		| TUnion(e1,e2) ->
				(match (typeOf e1), (typeOf e2) with
				| TechnoLang, TechnoLang -> TechnoLang
				| _ -> raise (TypeError "Input type to union is not of TechnoLang type"))
		| TIntersection(e1, e2) ->
				(match (typeOf e1), (typeOf e2) with
				| TechnoLang, TechnoLang -> TechnoLang
				| _ -> raise (TypeError "Input type to intersection is not of TechnoLang type"))
		| TConcat(s1, s2) ->
				(match (typeOf s1), (typeOf s2) with
				| TechnoString, TechnoString -> TechnoString
				| TechnoString, TechnoLang -> TechnoLang
				| TechnoLang, TechnoString -> TechnoLang
				| TechnoLang, TechnoLang -> TechnoLang
				| TechnoLang, TechnoInt -> TechnoLang
				| TechnoInt, TechnoLang -> TechnoLang
				| TechnoInt, TechnoString -> TechnoString
				| TechnoString, TechnoInt -> TechnoString
				| _ -> raise (TypeError "Input type to concatenation is not of TechnoString type"))
		| TStrLen(s) ->
				(match typeOf s with
				| TechnoString -> TechnoInt
				| _ -> raise (TypeError "Input type to strlen is not of TechnoInt type"))
		| TAppendToList(s,l) ->
				(match (typeOf s), (typeOf l) with
				| TechnoString, TechnoLang -> TechnoLang
				| _ -> raise (TypeError "Input type to prefixToList is not of TechnoString and / or TechnoString type"))
		| TPostfixToList(s,l) ->
				(match (typeOf s), (typeOf l) with
				| _ -> raise (TypeError "Input type to postfixToList is not of TechnoString and / or TechnoLang type"))
		| TCap(i, e) ->
				(match (typeOf i), (typeOf e) with
				| TechnoInt, TechnoLang -> TechnoLang
				| _ -> raise (TypeError "Cannot cap anything not of type TechnoLang"))
		| Eol(e1, e2) ->
				(match (typeOf e1), (typeOf e2) with
				| TechnoLang, TechnoLang -> TechnoLang
				| _ -> raise (TypeError "EOL: \";\" failed"))
		| TKleene(i, s) ->
				(match (typeOf i), (typeOf s) with
				| TechnoInt, TechnoString -> TechnoLang
				| _ -> raise (TypeError "Input types to kleene are not of type TechnoString and TechnoInt"))
		| TConcatABC(i, l) ->
				(match (typeOf i), (typeOf l) with
				| TechnoLang, TechnoInt -> TechnoLang
				| _ -> raise (TypeError "Input types to concatABC is not of type TechnoLang and TechnoInt"))
		| _ -> raise (TypeError "Expression is not recognisable")
;;

(*==== Begins evaluation of terms ====*)
let typeProg e = typeOf e ;;

(*==== Machine analysis method ====*)
let rec eval e =
	match e with
		| (TLang x) -> raise Terminated
		| (TString s) -> raise Terminated
		| (TInt n) -> raise Terminated

		| (TUnion(TLang(x), TLang(y))) -> TLang( lst_to_str(union (str_to_lst x) (str_to_lst y)))
		| (TUnion(TLang(x), e2)) -> let e2' = eval e2 in (TUnion(TLang(x), e2'))
		| (TUnion(e1, e2)) -> let e1' = eval e1 in (TUnion(e1', e2))

		| (TIntersection(TLang(x), TLang(y))) -> TLang(lst_to_str (intersect (str_to_lst x) (str_to_lst y)))
		| (TIntersection(TLang(x), e2)) -> let e2' = eval e2 in TIntersection(TLang(x), e2')
		| (TIntersection(e1, e2)) -> let e1' = eval e1 in TIntersection(e1', e2)

		| (TConcat(TString(s1), TString(s2))) -> (TString(((rm_quotes s1)^(rm_quotes s2))))
		| (TConcat(TString(s), TLang(l))) -> (TLang(lst_to_str(sort_uniq (appenderMaster s (str_to_lst l)))))
		| (TConcat(TLang(l), TString(s))) -> (TLang(lst_to_str(sort_uniq (postfixToList s (str_to_lst l)))))
		| (TConcat(TLang(l1), TLang(l2))) -> (TLang(lst_to_str(sort_uniq (concat (str_to_lst l1) (str_to_lst l2)))))
		| (TConcat(TLang(l), TInt(i))) -> (TLang(lst_to_str(sort_uniq (concatMaster i (str_to_lst l)))))
		| (TConcat(TInt(i), TLang(l))) -> (TLang(lst_to_str(sort_uniq (concatMaster i (str_to_lst l)))))
		| (TConcat(TInt(i), TString(s))) -> (TString(string_repeat i s))
		| (TConcat(TString(s), TInt(i))) -> (TString(string_repeat i s))
		| (TConcat(TLang(l), e2)) -> let e2' = eval e2 in (TConcat(TLang(l), e2'))
		| (TConcat(TString(s1), e2)) -> let e2' = eval e2 in (TConcat(TString(s1), e2'))
		| (TConcat(TInt(i), e2)) -> let e2' = eval e2 in (TConcat(TInt(i), e2'))
		| (TConcat(e1, e2)) -> let e1' = eval e1 in (TConcat(e1', e2))

		| (TStrLen(TString(s))) ->  TInt(String.length (rm_quotes s))
		| (TStrLen(e)) -> let e' = eval e in TStrLen(e')

		| (TAppendToList(TString(s), TLang(l))) -> TLang(lst_to_str(sort_uniq (appenderMaster s (str_to_lst l))))
		| (TAppendToList(TString(s), e2)) -> let e2' = eval e2 in (TAppendToList(TString(s), e2'))
		| (TAppendToList(e1, e2)) -> let e1' = eval e1 in TAppendToList(e1', e2)

		| (TCap(TInt(i), TLang(l))) -> TLang(lst_to_str (cap i (str_to_lst l)))
		| (TCap(TInt(i), e2)) -> let e2' = eval e2 in TCap(TInt(i), e2')
		| (TCap(e1, e2)) -> let e1' = eval e1 in TCap(e1', e2)

		| (TKleene(TInt(i), TString(s))) -> TLang(lst_to_str (kleeneIndividual i s))
		| (TKleene(TInt(i), e2)) -> let e2' = eval e2 in TKleene(TInt(i), e2')
		| (TKleene(e1, e2)) -> let e1' = eval e1 in TKleene(e1', e2)

		| (TConcatABC(TLang(l), TInt(i))) -> TLang(lst_to_str(concatMaster i (str_to_lst l)))
		| (TConcatABC(TLang(l), e2)) -> let e2' = eval e2 in TConcatABC(TLang(l), e2')
		| (TConcatABC(e1, e2)) -> let e1' = eval e1 in TConcatABC(e1', e2)

		| _ -> raise Terminated
;;

(*==== Begin evaluation of program ====*)
let rec evalloop e =
	try (
		let e' = eval e
		in evalloop e')
	 with Terminated ->
		if (isValue e) then
			e
		else
			raise StuckTerm
;;

let evalProg e = evalloop e;; (* <== Starts here *)

let evalProg e =
	match e with
		| Eol(Eol (e1, e2), e3)  -> Eol (evalProg (Eol (e1, e2)), evalProg(e3))
		| Eol(e1, e2) -> (Eol ((evalProg e1),(evalProg e2)))
		| e1 -> (evalloop e)
;;

let rec print_res res =
	match res with
		| (TLang x) -> print_string x
		| Eol(TLang(l1), TLang(l2)) -> print_res (TLang (l1)); print_string "\n"; print_res (TLang(l2))
		| Eol(Eol(TLang(l1), TLang(l2)), TLang(l3)) -> print_res (Eol(TLang(l1), TLang(l2))); print_string "\n"; print_res(TLang(l3))
		| (TInt n) -> print_int n
		| (TString s) -> print_string s
		| _ -> raise NonBaseTypeResult
;;
