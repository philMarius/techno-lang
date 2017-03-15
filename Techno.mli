(* Header file for Techno.ml *)

type technoType =
  | TechnoInt
  | TechnoBool
  | TechnoString
  | TechnoLinkSet
  | TechnoSet
  | TechnoValue

type tech =
| TNum of int
| TBool of bool
| TString of string
| TValue of tech
| TLinkSet of tech * tech
| TPlus of tech * tech
| TMinus of tech * tech
| TMultiply of tech * tech
| TDivide of tech * tech
| TExpo of tech * tech
| TMod of tech * tech
| TSet of tech
| TUnion of tech * tech

val typeProg : tech -> technoType
val evalProg : tech -> tech
val print_res : tech -> unit
