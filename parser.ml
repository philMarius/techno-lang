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

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"

	open Techno
# 19 "parser.ml"
let yytransl_const = [|
  258 (* LPAREN *);
  259 (* RPAREN *);
  260 (* STRING *);
  261 (* DELIM *);
  262 (* UNION *);
  263 (* LSETPAREN *);
  264 (* RSETPAREN *);
    0 (* EOF *);
  265 (* EOL *);
    0|]

let yytransl_block = [|
  257 (* LANGUAGE *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\000\000"

let yylen = "\002\000\
\002\000\001\000\003\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\002\000\000\000\005\000\000\000\000\000\000\000\
\001\000\003\000\000\000"

let yydgoto = "\002\000\
\005\000\006\000"

let yysindex = "\008\000\
\001\255\000\000\000\000\001\255\000\000\254\254\005\255\001\255\
\000\000\000\000\004\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\253\254"

let yygindex = "\000\000\
\000\000\253\255"

let yytablesize = 11
let yytable = "\004\000\
\007\000\003\000\004\000\008\000\011\000\004\000\009\000\010\000\
\001\000\008\000\008\000"

let yycheck = "\003\001\
\004\000\001\001\002\001\006\001\008\000\009\001\009\001\003\001\
\001\000\006\001\006\001"

let yynames_const = "\
  LPAREN\000\
  RPAREN\000\
  STRING\000\
  DELIM\000\
  UNION\000\
  LSETPAREN\000\
  RSETPAREN\000\
  EOF\000\
  EOL\000\
  "

let yynames_block = "\
  LANGUAGE\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 15 "parser.mly"
                ( _1 )
# 92 "parser.ml"
               : Techno.tech))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 18 "parser.mly"
                 ( TLang _1 )
# 99 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 19 "parser.mly"
                         ( _2 )
# 106 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 20 "parser.mly"
                      ( TUnion(_1, _3) )
# 114 "parser.ml"
               : 'expr))
(* Entry parser_main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let parser_main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Techno.tech)
