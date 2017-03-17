type token =
  | LANGUAGE of (string)
  | LPAREN
  | RPAREN
  | STRING
  | DELIM
  | UNION
  | LSETPAREN
  | RSETPAREN
  | EOF
  | EOL

val parser_main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Techno.tech
