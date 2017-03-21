type token =
  | LANGUAGE of (string)
  | STRING of (string)
  | INT of (int)
  | CONCAT
  | LENGTH
  | APPENDTOLIST
  | POSTFIXTOLIST
  | LPAREN
  | RPAREN
  | UNION
  | INTERSECT
  | EMPTYWORD
  | IDENT
  | DELIM
  | EOF
  | EOL
  | CAP
  | KLEENE
  | CONCATABC

val parser_main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Techno.tech
