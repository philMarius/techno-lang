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
  | TechnoInt
  | TechnoBool
  | TechnoString
  | TechnoLang

(* Grammar of the Techno language *)
type tech =
  | TNum of int
  | TBool of bool
  | TString of string
  | TPlus of tech * tech
  | TMinus of tech * tech
  | TMultiply of tech * tech
  | TDivide of tech * tech
  | TExpo of tech * tech
  | TMod of tech * tech
  | TLang of string
  | TUnion of tech * tech

let rec isValue e =
  match e with
    | TNum (n) -> true
    | TBool (b) -> true
    | TString (c) -> true
    | _ -> false
;;

(*==== Utilities functions ====*)

(* Checks whether a given number is even *)
let isEven n =
  n mod 2 = 0
;;

(* Exponential function for integers *)
let rec expoInt base power =
  if power < 0
  then raise InvalidNumberException
  else
    let rec aux acc base = function
      | 0 -> acc
      | 1 -> base * acc
      | e when isEven e -> aux acc (base * base) (e/2)
      | e -> aux (base * acc) (base * base) ((e-1)/2)
    in
    aux 1 base power
;;

let rec appendToList l i =
  match l with
  | [] -> [i]
  | h :: t -> h :: (appendToList t i)
;;

let rm_rparen s =
	Str.global_replace (Str.regexp "{") "" s;;

let rm_lparen s =
	Str.global_replace (Str.regexp "}") "" s;;

let uniq_sort l =
	let sort = List.sort compare l in
	let rec aux acc l =
		match l with
			| [] -> List.rev acc
			| [a] -> List.rev (a :: acc)
			| (a :: b :: t) ->
				if a = b
				then aux (b :: acc) acc
				else aux (b :: acc) (a :: acc)
	in aux [] l
;;

let str_to_lst str =
	let rm_paren str =
		rm_lparen (rm_rparen str)
	in uniq_sort (Str.split (Str.regexp ",") (rm_paren str))
;;


(*==== Type checking function ====*)
let rec typeOf e =
  match e with
    | TNum(n) -> TechnoInt
    | TBool(b) -> TechnoBool
    | TString(s) -> TechnoString
		| TLang(e1) -> TechnoLang
    | TPlus(e1,e2) ->
        (match (typeOf e1), (typeOf e2) with
        | TechnoInt, TechnoInt -> TechnoInt
        | _ -> raise TypeError)
    | TMinus(e1,e2) ->
        (match (typeOf e1), (typeOf e2) with
        | TechnoInt, TechnoInt -> TechnoInt
        | _ -> raise TypeError)
    | TMultiply(e1,e2) ->
        (match (typeOf e1), (typeOf e2) with
        | TechnoInt, TechnoInt -> TechnoInt
        | _ -> raise TypeError)
    | TDivide(e1,e2) ->
        (match (typeOf e1), (typeOf e2) with
        | TechnoInt, TechnoInt -> TechnoInt
        | _ -> raise TypeError)
    | TExpo(e1,e2) ->
        (match (typeOf e1), (typeOf e2) with
        | TechnoInt, TechnoInt -> TechnoInt
        | _ -> raise TypeError)
    | TMod(e1,e2) ->
        (match (typeOf e1), (typeOf e2) with
        | TechnoInt, TechnoInt -> TechnoInt
        | _ -> raise TypeError)
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
    | (TNum n) -> raise Terminated
    | (TBool b) -> raise Terminated
    | (TString s) -> raise Terminated
    | (TLang(x)) -> (TLang(x))

    | (TPlus(TNum(n), TNum(m))) -> (TNum( n + m ))
    | (TPlus(TNum(n), e2)) -> let (e2') = (eval e2) in (TPlus(TNum(n),e2'))
    | (TPlus(e1,e2)) -> let (e1') = (eval e1) in (TPlus(e1', e2))

    | (TMinus(TNum(n), TNum(m))) -> (TNum( n - m ))
    | (TMinus(TNum(n), e2)) -> let (e2') = (eval e2) in (TMinus(TNum(n),e2'))
    | (TMinus(e1,e2)) -> let (e1') = (eval e1) in (TMinus(e1', e2))

    | (TMultiply(TNum(n), TNum(m))) -> (TNum( n * m ))
    | (TMultiply(TNum(n), e2)) -> let (e2') = (eval e2) in (TMultiply(TNum(n),e2'))
    | (TMultiply(e1,e2)) -> let (e1') = (eval e1) in (TMultiply(e1', e2))

    | (TDivide(TNum(n), TNum(m))) -> (TNum( n / m ))
    | (TDivide(TNum(n), e2)) -> let (e2') = (eval e2) in (TDivide(TNum(n),e2'))
    | (TDivide(e1,e2)) -> let (e1') = (eval e1) in (TDivide(e1', e2))

    | (TExpo(TNum(n), TNum(m))) -> (TNum( expoInt n m ))
    | (TExpo(TNum(n), e2)) -> let (e2') = (eval e2) in (TExpo(TNum(n),e2'))
    | (TExpo(e1,e2)) -> let (e1') = (eval e1) in (TExpo(e1', e2))

    | (TMod(TNum(n), TNum(m))) ->(TNum(n mod m))
    | (TMod(TNum(n), e2)) -> let (e2') = (eval e2) in (TMod(TNum(n),e2'))
    | (TMod(e1,e2)) -> let (e1') = (eval e1) in (TMod(e1', e2))

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
