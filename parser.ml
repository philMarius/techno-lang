type token =
  | INT of (int)
  | STRING of (string)
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

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"

	open Techno
# 29 "parser.ml"
let yytransl_const = [|
  259 (* PLUS *);
  260 (* MINUS *);
  261 (* MULTIPLY *);
  262 (* DIVIDE *);
  263 (* EXPO *);
  264 (* MOD *);
  265 (* LPAREN *);
  266 (* RPAREN *);
  267 (* DELIM *);
  268 (* UNION *);
  269 (* LSETPAREN *);
  270 (* RSETPAREN *);
  271 (* INT_TYPE *);
  272 (* BOOL_TYPE *);
  273 (* TRUE *);
  274 (* FALSE *);
    0 (* EOF *);
  275 (* EOL *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* STRING *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\004\000\004\000\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\003\000\001\000\001\000\001\000\003\000\
\001\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\005\000\007\000\000\000\000\000\006\000\009\000\
\020\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\001\000\010\000\000\000\008\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\018\000"

let yydgoto = "\002\000\
\009\000\000\000\012\000\013\000"

let yysindex = "\002\000\
\019\255\000\000\000\000\000\000\019\255\019\255\000\000\000\000\
\000\000\069\255\122\255\132\255\250\254\019\255\019\255\019\255\
\019\255\019\255\019\255\019\255\000\000\000\000\019\255\000\000\
\017\255\017\255\255\254\255\254\253\254\253\254\142\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\254\254\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\103\255\105\255\079\255\091\255\035\255\052\255\247\254\000\000"

let yygindex = "\000\000\
\000\000\000\000\255\255\003\000"

let yytablesize = 154
let yytable = "\010\000\
\017\000\017\000\001\000\011\000\017\000\018\000\019\000\024\000\
\020\000\017\000\020\000\019\000\025\000\026\000\027\000\028\000\
\029\000\030\000\031\000\003\000\004\000\016\000\017\000\018\000\
\019\000\032\000\000\000\005\000\020\000\000\000\000\000\006\000\
\000\000\000\000\000\000\007\000\008\000\015\000\015\000\015\000\
\015\000\015\000\015\000\000\000\015\000\015\000\000\000\000\000\
\015\000\000\000\000\000\000\000\000\000\015\000\016\000\016\000\
\016\000\016\000\016\000\016\000\000\000\016\000\016\000\000\000\
\000\000\016\000\000\000\000\000\000\000\000\000\016\000\014\000\
\015\000\016\000\017\000\018\000\019\000\000\000\000\000\000\000\
\020\000\013\000\013\000\013\000\013\000\000\000\000\000\021\000\
\013\000\013\000\000\000\000\000\013\000\014\000\014\000\014\000\
\014\000\013\000\000\000\000\000\014\000\014\000\000\000\000\000\
\014\000\011\000\011\000\012\000\012\000\014\000\000\000\000\000\
\011\000\011\000\012\000\012\000\011\000\000\000\012\000\000\000\
\000\000\011\000\000\000\012\000\014\000\015\000\016\000\017\000\
\018\000\019\000\000\000\022\000\000\000\020\000\014\000\015\000\
\016\000\017\000\018\000\019\000\000\000\000\000\023\000\020\000\
\014\000\015\000\016\000\017\000\018\000\019\000\000\000\000\000\
\000\000\020\000"

let yycheck = "\001\000\
\010\001\011\001\001\000\005\000\014\001\007\001\008\001\014\001\
\012\001\019\001\012\001\014\001\014\000\015\000\016\000\017\000\
\018\000\019\000\020\000\001\001\002\001\005\001\006\001\007\001\
\008\001\023\000\255\255\009\001\012\001\255\255\255\255\013\001\
\255\255\255\255\255\255\017\001\018\001\003\001\004\001\005\001\
\006\001\007\001\008\001\255\255\010\001\011\001\255\255\255\255\
\014\001\255\255\255\255\255\255\255\255\019\001\003\001\004\001\
\005\001\006\001\007\001\008\001\255\255\010\001\011\001\255\255\
\255\255\014\001\255\255\255\255\255\255\255\255\019\001\003\001\
\004\001\005\001\006\001\007\001\008\001\255\255\255\255\255\255\
\012\001\003\001\004\001\005\001\006\001\255\255\255\255\019\001\
\010\001\011\001\255\255\255\255\014\001\003\001\004\001\005\001\
\006\001\019\001\255\255\255\255\010\001\011\001\255\255\255\255\
\014\001\003\001\004\001\003\001\004\001\019\001\255\255\255\255\
\010\001\011\001\010\001\011\001\014\001\255\255\014\001\255\255\
\255\255\019\001\255\255\019\001\003\001\004\001\005\001\006\001\
\007\001\008\001\255\255\010\001\255\255\012\001\003\001\004\001\
\005\001\006\001\007\001\008\001\255\255\255\255\011\001\012\001\
\003\001\004\001\005\001\006\001\007\001\008\001\255\255\255\255\
\255\255\012\001"

let yynames_const = "\
  PLUS\000\
  MINUS\000\
  MULTIPLY\000\
  DIVIDE\000\
  EXPO\000\
  MOD\000\
  LPAREN\000\
  RPAREN\000\
  DELIM\000\
  UNION\000\
  LSETPAREN\000\
  RSETPAREN\000\
  INT_TYPE\000\
  BOOL_TYPE\000\
  TRUE\000\
  FALSE\000\
  EOF\000\
  EOL\000\
  "

let yynames_block = "\
  INT\000\
  STRING\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 23 "parser.mly"
                ( _1 )
# 168 "parser.ml"
               : Techno.tech))
; (fun __caml_parser_env ->
    Obj.repr(
# 26 "parser.mly"
                 ( TechnoInt )
# 174 "parser.ml"
               : Techno.technoType))
; (fun __caml_parser_env ->
    Obj.repr(
# 27 "parser.mly"
                 ( TechnoBool )
# 180 "parser.ml"
               : Techno.technoType))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Techno.technoType) in
    Obj.repr(
# 28 "parser.mly"
                       ( _2 )
# 187 "parser.ml"
               : Techno.technoType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 31 "parser.mly"
             ( TNum _1 )
# 194 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 32 "parser.mly"
              ( TBool true )
# 200 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 33 "parser.mly"
               ( TString _1 )
# 207 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'set_type) in
    Obj.repr(
# 34 "parser.mly"
                                ( TSet _2 )
# 214 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 35 "parser.mly"
               ( TBool false )
# 220 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 36 "parser.mly"
                         ( _2 )
# 227 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 37 "parser.mly"
                      ( TPlus(_1, _3) )
# 235 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 38 "parser.mly"
                       ( TMinus(_1, _3) )
# 243 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 39 "parser.mly"
                        ( TMultiply(_1, _3) )
# 251 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 40 "parser.mly"
                       ( TDivide(_1, _3) )
# 259 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 41 "parser.mly"
                     ( TExpo(_1, _3) )
# 267 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 42 "parser.mly"
                     ( TMod(_1, _3) )
# 275 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 43 "parser.mly"
                      ( TUnion(_1, _3) )
# 283 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'set_type) in
    Obj.repr(
# 46 "parser.mly"
                         ( TLinkSet(_1, _3) )
# 291 "parser.ml"
               : 'set_type))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 47 "parser.mly"
              ( TValue(_1) )
# 298 "parser.ml"
               : 'set_type))
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
