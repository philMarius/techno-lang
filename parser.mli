type token =
  | LANGUAGE of (string)
  | STRING of (string)
  | INT of (int)
  | CONCAT
  | LENGTH
  | APPENDTOLIST
  | LPAREN
  | RPAREN
  | UNION
  | INTERSECT
  | EMPTYWORD
  | IDENT
  | DELIM
  | EOL

val parser_main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Techno.tech
