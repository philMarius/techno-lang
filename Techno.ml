(* File Techno.ml *)
exception LookupError ;;
exception TypeError ;;
exception Terminated ;;
exception InvalidNumberException ;;
exception NonBaseTypeResult ;;
exception StuckTerm ;;

open Printf;;

(* Types of the Techno language *)
type technoType = TechnoInt | TechnoBool | TechnoFun of technoType * technoType

(* Grammar of the Techno language *)
type tech =
  TNum of int
  | TBool of bool
  | TPlus of tech * tech
  | TMinus of tech * tech
  | TMultiply of tech * tech
  | TDivide of tech * tech
  | TExpo of tech * tech
  | TMod of tech * tech

let rec isValue e =
  match e with
    | TNum (n) -> true
    | TBool (b) -> true
    | _ -> false
;;

(* Utilities functions *)

let isEven n =
  n mod 2 = 0;;

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
    aux 1 base power;;


(* Type checking function *)
let rec typeOf e =
  match e with
    | TNum(n) -> TechnoInt
    | TBool(b) -> TechnoBool
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
    (* | _ -> raise TypeError *)
;;

(* Begins evaluation of terms *)
let typeProg e = typeOf e ;;

(* Machine anlaysis method *)
let rec eval e =
  match e with
    | (TNum n) -> raise Terminated
    | (TBool b) -> raise Terminated

    | (TPlus(TNum(n), TNum(m))) -> (TNum( n + m ))
    | (TMinus(TNum(n), TNum(m))) -> (TNum( n - m ))
    | (TMultiply(TNum(n), TNum(m))) -> (TNum( n * m ))
    | (TDivide(TNum(n), TNum(m))) -> (TNum( n / m ))
    | (TExpo(TNum(n), TNum(m))) -> (TNum( expoInt n m ))
    | (TMod(TNum(n), TNum(m))) ->(TNum(n mod m))

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

let evalProg e = evalloop e;;

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
