type token =
  | LANGUAGE of (string)
  | LPAREN
  | RPAREN
  | UNION
  | INTERSECT
  | EOL

val parser_main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Techno.tech
