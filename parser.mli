type token =
  | INT of (int)
  | PLUS
  | MINUS
  | MULTIPLY
  | DIVIDE
  | EXPO
  | MOD
  | LPAREN
  | RPAREN
  | INT_TYPE
  | BOOL_TYPE
  | EOF

val parser_main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Techno.tech
