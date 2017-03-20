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

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"

	open Techno
	open Utils
# 24 "parser.ml"
let yytransl_const = [|
  260 (* CONCAT *);
  261 (* LENGTH *);
  262 (* APPENDTOLIST *);
  263 (* LPAREN *);
  264 (* RPAREN *);
  265 (* UNION *);
  266 (* INTERSECT *);
  267 (* EMPTYWORD *);
  268 (* IDENT *);
  269 (* DELIM *);
  270 (* EOL *);
    0|]

let yytransl_block = [|
  257 (* LANGUAGE *);
  258 (* STRING *);
  259 (* INT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\001\000\003\000\003\000\003\000\003\000\
\004\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\003\000\004\000\002\000\000\000\000\000\000\000\
\011\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\001\000\000\000\000\000\005\000\000\000\006\000\007\000\009\000"

let yydgoto = "\002\000\
\009\000\010\000"

let yysindex = "\002\000\
\049\255\000\000\000\000\000\000\000\000\001\255\049\255\049\255\
\000\000\015\255\049\255\029\255\018\255\049\255\049\255\049\255\
\000\000\053\255\011\255\000\000\011\255\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\255\254\000\000\009\255\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\033\000"

let yytablesize = 63
let yytable = "\010\000\
\010\000\010\000\001\000\010\000\010\000\010\000\010\000\011\000\
\000\000\008\000\008\000\008\000\010\000\008\000\008\000\008\000\
\008\000\000\000\014\000\015\000\016\000\014\000\008\000\015\000\
\016\000\020\000\015\000\016\000\017\000\003\000\004\000\005\000\
\014\000\006\000\007\000\008\000\000\000\015\000\016\000\012\000\
\013\000\000\000\000\000\018\000\019\000\000\000\021\000\022\000\
\023\000\003\000\004\000\005\000\000\000\006\000\007\000\008\000\
\014\000\000\000\000\000\000\000\024\000\015\000\016\000"

let yycheck = "\001\001\
\002\001\003\001\001\000\005\001\006\001\007\001\008\001\007\001\
\255\255\001\001\002\001\003\001\014\001\005\001\006\001\007\001\
\008\001\255\255\004\001\009\001\010\001\004\001\014\001\009\001\
\010\001\008\001\009\001\010\001\014\001\001\001\002\001\003\001\
\004\001\005\001\006\001\007\001\255\255\009\001\010\001\007\000\
\008\000\255\255\255\255\011\000\012\000\255\255\014\000\015\000\
\016\000\001\001\002\001\003\001\255\255\005\001\006\001\007\001\
\004\001\255\255\255\255\255\255\008\001\009\001\010\001"

let yynames_const = "\
  CONCAT\000\
  LENGTH\000\
  APPENDTOLIST\000\
  LPAREN\000\
  RPAREN\000\
  UNION\000\
  INTERSECT\000\
  EMPTYWORD\000\
  IDENT\000\
  DELIM\000\
  EOL\000\
  "

let yynames_block = "\
  LANGUAGE\000\
  STRING\000\
  INT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 25 "parser.mly"
                     ( _1 )
# 122 "parser.ml"
               : Techno.tech))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 28 "parser.mly"
                 ( TInt _1 )
# 129 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 29 "parser.mly"
                     ( TLang _1 )
# 136 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 30 "parser.mly"
                   ( TString _1 )
# 143 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 31 "parser.mly"
                             ( _2 )
# 150 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 32 "parser.mly"
                           ( TUnion(_1, _3) )
# 158 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 33 "parser.mly"
                             ( TIntersection(_1, _3) )
# 166 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 34 "parser.mly"
                           ( TConcat(_1, _3) )
# 174 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 35 "parser.mly"
                                  ( TStrLen _3 )
# 181 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 36 "parser.mly"
                               ( TAppendToList(_2,_3) )
# 189 "parser.ml"
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
