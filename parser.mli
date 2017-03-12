type token =
  | INT of (int)
  | PLUS
  | MINUS
  | MULTIPLY
  | DIVIDE
  | LPAREN
  | RPAREN
  | EOF
  | EXPO
  | MOD
  | INT_TYPE
  | BOOL_TYPE

val parser_main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Techno.tech
