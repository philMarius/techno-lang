type token =
  | LANGUAGE of (string)
  | LPAREN
  | RPAREN
  | UNION
  | INTERSECT
  | EOL

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"

	open Techno
# 15 "parser.ml"
let yytransl_const = [|
  258 (* LPAREN *);
  259 (* RPAREN *);
  260 (* UNION *);
  261 (* INTERSECT *);
  262 (* EOL *);
    0|]

let yytransl_block = [|
  257 (* LANGUAGE *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\000\000"

let yylen = "\002\000\
\002\000\001\000\003\000\003\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\002\000\000\000\006\000\000\000\000\000\000\000\
\000\000\001\000\003\000\004\000\005\000"

let yydgoto = "\002\000\
\005\000\006\000"

let yysindex = "\010\000\
\008\255\000\000\000\000\008\255\000\000\253\254\003\255\008\255\
\008\255\000\000\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\252\255"

let yytablesize = 11
let yytable = "\007\000\
\008\000\009\000\010\000\012\000\013\000\011\000\008\000\009\000\
\003\000\004\000\001\000"

let yycheck = "\004\000\
\004\001\005\001\006\001\008\000\009\000\003\001\004\001\005\001\
\001\001\002\001\001\000"

let yynames_const = "\
  LPAREN\000\
  RPAREN\000\
  UNION\000\
  INTERSECT\000\
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
# 16 "parser.mly"
                 ( _1 )
# 80 "parser.ml"
               : Techno.tech))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 19 "parser.mly"
                 ( TLang _1 )
# 87 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 20 "parser.mly"
                         ( _2 )
# 94 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 21 "parser.mly"
                       ( TUnion(_1, _3) )
# 102 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 22 "parser.mly"
                         ( TIntersection(_1, _3) )
# 110 "parser.ml"
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
