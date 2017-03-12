type technoType = TechnoInt | TechnoBool | TechnoFun of technoType * technoType

type tech =
  TNum of int
  | TBool of bool
  | TPlus of tech * tech
  | TMinus of tech * tech
  | TMultiply of tech * tech
  | TDivide of tech * tech
  | TExpo of tech * tech
  | TMod of tech * tech

val typeProg : tech -> technoType
val evalProg : tech -> tech
val print_res : tech -> unit
