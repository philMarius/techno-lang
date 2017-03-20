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
	| TIntersection of tech * tech
  | TString of string
  | TConcat of tech * tech
  | TStrLen of tech
  | TAppendToList of tech * tech

let rec isValue e =
  match e with
		| TLang (x) -> true
    | TString (s) -> true
    | TInt (n) -> true
    | _ -> false
;;

(*==== Utilities functions ====*)

(* Append to end of a list *)
let append l1 l2 =
	let rec aux l3 = function
		| [] -> l3
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

(* Convert string form of set to list *)
let str_to_lst str =
	let rm_paren str =
		rm_lparen (rm_rparen str)
	in uniq_sort (Str.split (Str.regexp ",") (rm_paren str))
;;

(* Union of two sets *)
let union l1 l2 =
	uniq_sort (append l1 l2)
;;

(* Different union function *)
let union2 l1 l2 =
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
	"{"^String.concat ", " (uniq_sort l)^"}"
;;

(* Remove quotes from the string *)
let rm_quotes s =
  Str.global_replace (Str.regexp "\"") "" s
;;

(* Add quotes back to the string *)
let add_quotes s =
  "\""^s^"\""
;;

(* Generate string of length l comprised of string n    --> Use String.make *)
let gen_str l n =
	let rec aux l n acc =
		if n>0 then aux l (n-1) acc ^ l else ""
  in aux l n "";;

(* Generate list of length n of  *)
let kleene n l1 =
	let rec aux x l2 = function
		| [] -> l2
		| h::t -> if x < n then aux (x+1) ((h^(gen_str "a" x)) :: l2) l1 else List.rev l2
  in aux 0 [] l1
;;

(* Take letter n and concatenate it with every element in list l2 *)
let append_letter_to_list n l2 =
  let destring x = if (String.contains x '\"') then (rm_quotes x) else x in
  let rec aux l3 = function
    | [] -> List.rev l3
    | h::t -> aux (((destring n)^h)::l3) t
  in aux [] l2;;

(* Limit length of list l1 to length n *)
let limit_list_length n l1 =
  let rec aux x l2 = function
    | [] -> l2
    | h :: t -> if x < n then aux (x + 1) (h :: l2) t else List.rev l2
  in aux 0 [] l1;;

(*  *)
let concat2 n l1 =
  let rec aux = function
    | [] -> []
    | h :: t -> limit_list_length n (append_letter_to_list h ["aa"; "ab"; "ac"; "ba"; "bb"; "bc"; "ca"; "cb"; "cc"; "aaa"; "aab"; "aac"; "aba"; "abb"; "abc"; "aca"; "acb"; "acc"; "baa";"bab";"bac";"bba";"bbb";"bbc";"bca";"bcb";"bcc";"caa";"cab";"cac";"cba";"cbb";"cbc";"cca";"ccb";"ccc";"aaaa";"aaab";"aaac";"aaba"])
  in aux l1;;



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
        | _ -> raise (TypeError "Input type to concatenation is not of TechnoString type"))
    | TStrLen(s) ->
        (match typeOf s with
        | TechnoString -> TechnoInt
        | _ -> raise (TypeError "Input type to strlen is not of TechnoInt type"))
    | TAppendToList(s,l) ->
        (match (typeOf s), (typeOf l) with
        | TechnoString, TechnoLang -> TechnoLang
        | _ -> raise (TypeError "Input type to appendToList is not of TechnoString and / TechnoString type"))
    | _ -> raise (TypeError "Expression is not recognisable")


(*==== Begins evaluation of terms ====*)
let typeProg e = typeOf e ;;

(*==== Machine analysis method ====*)
let rec eval e =
  match e with
    | (TLang x) -> raise Terminated
    | (TString s) -> raise Terminated
    | (TInt n) -> raise Terminated

		| (TUnion(TLang(x), TLang(y))) -> TLang( lst_to_str(union2 (str_to_lst x) (str_to_lst y)))
		| (TUnion(TLang(x), e2)) -> let e2' = eval e2 in (TUnion(TLang(x), e2'))
		| (TUnion(e1, e2)) -> let e1' = eval e1 in (TUnion(e1', e2))

		| (TIntersection(TLang(x), TLang(y))) -> TLang(lst_to_str (intersect (str_to_lst x) (str_to_lst y)))
		| (TIntersection(TLang(x), e2)) -> let e2' = eval e2 in TIntersection(TLang(x), e2')
		| (TIntersection(e1, e2)) -> let e1' = eval e1 in TIntersection(e1', e2)

    | (TConcat(TString(s1), TString(s2))) -> (TString(add_quotes((rm_quotes s1)^(rm_quotes s2))))
    | (TConcat(TString(s1), e2)) -> let e2' = eval e2 in (TConcat(TString(s1), e2'))
    | (TConcat(e1, e2)) -> let e1' = eval e1 in (TConcat(e1', e2))

    | (TStrLen(TString(s))) ->  TInt(String.length (rm_quotes s))
    | (TStrLen(e)) -> let e' = eval e in TStrLen(e')

    | (TAppendToList(TString(s), TLang(l))) -> TLang(lst_to_str (append_letter_to_list s (str_to_lst l)))
    | (TAppendToList(TString(s), e2)) -> let e2' = eval e2 in (TAppendToList(TString(s), e2'))
    | (TAppendToList(e1, e2)) -> let e1' = eval e1 in TAppendToList(e1', e2)

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

(*==== Printing methods ====*)
let rec type_to_string tT =
  match tT with
    | TechnoInt -> "int"
		| TechnoLang -> "lang"
    | TechnoString -> "string"
;;

let print_res res =
  match res with
    | (TInt n) -> print_int n; print_string " : int"
		| (TLang x) -> print_string x; print_string " : lang"
    | (TString s) -> print_string s; print_string " : string"
    | _ -> raise NonBaseTypeResult
;;
