(* File Techno.ml *)
exception LookupError ;;
exception TypeError ;;
exception Terminated ;;
exception InvalidNumberException ;;

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
      | e when isEven e -> aux acc (base * base) (e / 2)
      | e -> aux (base * acc) (base * base) ((e-1)/2)
    in
    aux 1 base power;;


(* Type checking function *)
let rec typeOf env e =
  match e with
    | TNum(n) -> TechnoInt
    | TBool(b) -> TechnoBool
    | TPlus(e1,e2) ->
        (match (typeOf env e1), (typeOf env e2) with
        | TechnoInt, TechnoInt -> TechnoInt
        | _ -> raise TypeError)
    | TMinus(e1,e2) ->
        (match (typeOf env e1), (typeOf env e2) with
        | TechnoInt, TechnoInt -> TechnoInt
        | _ -> raise TypeError)
    | TMultiply(e1,e2) ->
        (match (typeOf env e1), (typeOf env e2) with
        | TechnoInt, TechnoInt -> TechnoInt
        | _ -> raise TypeError)
    | TDivide(e1,e2) ->
        (match (typeOf env e1), (typeOf env e2) with
        | TechnoInt, TechnoInt -> TechnoInt
        | _ -> raise TypeError)
    | TExpo(e1,e2) ->
        (match (typeOf env e1), (typeOf env e2) with
        | TechnoInt, TechnoInt -> TechnoInt
        | _ -> raise TypeError)
    | TMod(e1,e2) ->
        (match (typeOf env e1), (typeOf env e2) with
        | TechnoInt, TechnoInt -> TechnoInt
        | _ -> raise TypeError)
    | _ -> raise TypeError
;;

(* NGL I don't know what this shit is but apparently we need it *)
let typeProg e = typeOf (Env []) e ;;

(* Machine anlaysis method *)
let rec eval env e =
  match e with
    | (TNum n) -> raise Terminated
    | (TBool b) -> raise Terminated

    | (TPlus(TNum(n), TNum(m))) -> (TNum( n + m ) , env)
    | (TMinus(TNum(n), TNum(m))) -> (TNum( n - m ) , env)
    | (TMultiply(TNum(n), TNum(m))) -> (TNum( n * m ) , env)
    | (TDivide(TNum(n), TNum(m))) -> (TNum( n / m ) , env)
    | (TExpo(TNum(n), TNum(m))) -> (TNum( expoInt n m ), env)
    | (TMod(TNum(n), TNum(m))) ->(TNum(n mod m), env)

    | _ -> raise Terminated
;;
