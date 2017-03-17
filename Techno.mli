(* Header file for Techno.ml *)

(* Types of the Techno language *)
type technoType =
  | TechnoInt
  | TechnoBool
  | TechnoString
  | TechnoSet

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
  | TSet of string
  | TUnion of tech * tech

val typeProg : tech -> technoType
val evalProg : tech -> tech
val print_res : tech -> unit
