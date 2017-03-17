(* File Techno.ml *)

exception LookupError ;;
exception TypeError ;;
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

let rec isValue e =
  match e with
    | TBool (b) -> true
    | TString (c) -> true
    | _ -> false
;;

(*==== Utilities functions ====*)

let append l1 l2 =
	let rec aux l3 = function
		| [] -> l3
		| h::t -> aux (h::l3) t in
	aux l1 l2;;

let rm_rparen s =
	Str.global_replace (Str.regexp "{") "" s;;

let rm_lparen s =
	Str.global_replace (Str.regexp "}") "" s;;

let uniq_sort l =
	let sort = List.sort compare l in
	let rec aux l2 = function
		| [] -> List.rev l2
		| h :: t -> if List.mem h l2 then aux l2 t else aux (h :: l2) t
	in aux [] sort
;;

let str_to_lst str =
	let rm_paren str =
		rm_lparen (rm_rparen str)
	in uniq_sort (Str.split (Str.regexp ",") (rm_paren str))
;;

let union l1 l2 =
	uniq_sort (append l1 l2);;

let rec intersect l1 l2 =
    match l1 with [] -> []
        | h1::t1 -> (
          match l2 with [] -> []
              | h2::t2 when h1 < h2 -> intersect t1 l2
              | h2::t2 when h1 > h2 -> intersect l1 t2
              | h2::t2 -> (
                match intersect t1 t2 with [] -> [h1]
                    | h3::t3 as l when h3 = h1 -> l
                    | h3::t3 as l -> h1::l
              )
        );;

(*==== Type checking function ====*)
let rec typeOf e =
  match e with
		| TLang(e1) -> TechnoLang
    | TUnion(e1,e2) ->
        (match (typeOf e1), (typeOf e2) with
        | TechnoLang, TechnoLang -> TechnoLang
        | _ -> raise TypeError)
    | _ -> raise TypeError


(*==== Begins evaluation of terms ====*)
let typeProg e = typeOf e ;;

(*==== Machine analysis method ====*)
let rec eval e =
  match e with
    | (TLang x) -> TLang x

		| (TUnion(TLang(x), TLang(y))) -> union (str_to_lst x) (str_to_lst y)
		| (TUnion(TLang(x), e2)) -> let (e2') = (eval e2) in (TUnion(TLang(x), e2'))
		| (TUnion(e1, e2)) -> let e1' = eval e1 in (TUnion(e1', e2))

    | _ -> raise Terminated
;;

(* Begin evaluation of program *)
let rec evalloop e =
  try (
    let (e') = (eval e)
    in (evalloop e')
) with Terminated ->
  if (isValue e) then
    e
  else
    raise StuckTerm
;;

let evalProg e = evalloop e;; (* <== Starts here *)

(* Printing methods *)
let rec type_to_string tT =
  match tT with
    | TechnoInt -> "int"
    | TechnoBool -> "bool"
;;

let print_res res =
  match res with
    | (TNum i) -> print_int i ; print_string " : int"
    | (TBool b) -> print_string (if b then "true" else "false") ; print_string " : bool"
    | _ -> raise NonBaseTypeResult
;;
