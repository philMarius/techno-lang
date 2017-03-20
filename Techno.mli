(* Header file for Techno.ml *)

(* Types of the Techno language *)
type technoType =
  | TechnoLang
  | TechnoString
  | TechnoInt

(* Grammar of the Techno language *)
type tech =
  | TInt of int
  | TLang of string
  | TUnion of tech * tech
  | TIntersection of tech * tech
  | TString of string
  | TConcat of tech * tech
  | TStrLen of tech
	| TAppendToList of tech * tech


val typeProg : tech -> technoType
val evalProg : tech -> tech
val print_res : tech -> unit
