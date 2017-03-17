type token =
  | INT of (int)
  | STRING of (string)
  | LANGUAGE of (string)
  | PLUS
  | MINUS
  | MULTIPLY
  | DIVIDE
  | EXPO
  | MOD
  | LPAREN
  | RPAREN
  | DELIM
  | UNION
  | LSETPAREN
  | RSETPAREN
  | INT_TYPE
  | BOOL_TYPE
  | TRUE
  | FALSE
  | EOF
  | EOL

val parser_main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Techno.tech
