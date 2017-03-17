(* File Techno.ml *)

exception LookupError ;;
exception TypeError of string;;
exception Terminated ;;
exception InvalidNumberException ;;
exception NonBaseTypeResult ;;
exception StuckTerm ;;

open Printf;;
open Str;;

(* Types of the Techno language *)
type technoType =
  | TechnoLang

(* Grammar of the Techno language *)
type tech =
  | TLang of string
  | TUnion of tech * tech
	| TIntersection of tech * tech

let rec isValue e =
  match e with
		| TLang (x) -> true
    | _ -> false
;;

(*==== Utilities functions ====*)

let append l1 l2 =
	let rec aux l3 = function
		| [] -> l3
		| h::t -> aux (h::l3) t in
	aux l1 l2
;;

let rm_rparen s =
	Str.global_replace (Str.regexp "{") "" s
;;

let rm_lparen s =
	Str.global_replace (Str.regexp "}") "" s
;;

let uniq_sort l =
	let sort = List.sort compare l in
	let rec aux l2 = function
		| [] -> List.rev l2
		| h :: t -> if (List.mem h l2) then aux l2 t else aux (h :: l2) t
	in aux [] sort
;;

let str_to_lst str =
	let rm_paren str =
		rm_lparen (rm_rparen str)
	in uniq_sort (Str.split (Str.regexp ",") (rm_paren str))
;;

let union l1 l2 =
	uniq_sort (append l1 l2)
;;

let union2 l1 l2 =
	uniq_sort (List.merge compare l1 l2)
;;

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

let lst_to_str l =
	"{"^String.concat ", " (uniq_sort l)^"}"
;;

(*==== Type checking function ====*)
let rec typeOf e =
  match e with
		| TLang(e1) -> TechnoLang
    | TUnion(e1,e2) ->
        (match (typeOf e1), (typeOf e2) with
        | TechnoLang, TechnoLang -> TechnoLang
        | _ -> raise (TypeError "Input type to union is not of TechnoLang type"))
		| TIntersection(e1, e2) ->
				(match (typeOf e1), (typeOf e2) with
				| TechnoLang, TechnoLang -> TechnoLang
				| _ -> raise (TypeError "Input type to intersection is not of TechnoLang type"))
    | _ -> raise (TypeError "Expression is not recognisable")


(*==== Begins evaluation of terms ====*)
let typeProg e = typeOf e ;;

(*==== Machine analysis method ====*)
let rec eval e =
  match e with
    | (TLang x) -> raise Terminated

		| (TUnion(TLang(x), TLang(y))) -> TLang( lst_to_str(union (str_to_lst x) (str_to_lst y)))
		| (TUnion(TLang(x), e2)) -> let e2' = eval e2 in (TUnion(TLang(x), e2'))
		| (TUnion(e1, e2)) -> let e1' = eval e1 in (TUnion(e1', e2))

		| (TIntersection(TLang(x), TLang(y))) -> TLang(lst_to_str (intersect (str_to_lst x) (str_to_lst y)))
		| (TIntersection(TLang(x), e2)) -> let e2' = eval e2 in TIntersection(TLang(x), e2')
		| (TIntersection(e1, e2)) -> let e1' = eval e1 in TIntersection(e1', e2)

    | _ -> raise Terminated
;;

(* Begin evaluation of program *)
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

(* Printing methods *)
let rec type_to_string tT =
  match tT with
		| TechnoLang -> "lang"
;;

let print_res res =
  match res with
		| (TLang x) -> print_string (lst_to_str (str_to_lst x)); print_string " : lang"
    | _ -> raise NonBaseTypeResult
;;
