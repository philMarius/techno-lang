(* Header file for Techno.ml *)

(* Types of the Techno language *)
type technoType =
  | TechnoLang

(* Grammar of the Techno language *)
type tech =
  | TLang of string
  | TUnion of tech * tech
  | TIntersection of tech * tech

val typeProg : tech -> technoType
val evalProg : tech -> tech
val print_res : tech -> unit
