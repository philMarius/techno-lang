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

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"

	open Techno
# 30 "parser.ml"
let yytransl_const = [|
  260 (* PLUS *);
  261 (* MINUS *);
  262 (* MULTIPLY *);
  263 (* DIVIDE *);
  264 (* EXPO *);
  265 (* MOD *);
  266 (* LPAREN *);
  267 (* RPAREN *);
  268 (* DELIM *);
  269 (* UNION *);
  270 (* LSETPAREN *);
  271 (* RSETPAREN *);
  272 (* INT_TYPE *);
  273 (* BOOL_TYPE *);
  274 (* TRUE *);
  275 (* FALSE *);
    0 (* EOF *);
  276 (* EOL *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* STRING *);
  259 (* LANGUAGE *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\003\000\001\000\001\000\001\000\001\000\
\001\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\005\000\007\000\008\000\000\000\006\000\009\000\
\018\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\001\000\010\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yydgoto = "\002\000\
\009\000\000\000\010\000"

let yysindex = "\004\000\
\255\254\000\000\000\000\000\000\000\000\255\254\000\000\000\000\
\000\000\006\255\071\255\255\254\255\254\255\254\255\254\255\254\
\255\254\255\254\000\000\000\000\089\255\089\255\251\254\251\254\
\249\254\249\254\081\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\046\255\054\255\034\255\042\255\
\016\255\024\255\252\254"

let yygindex = "\000\000\
\000\000\000\000\055\000"

let yytablesize = 102
let yytable = "\003\000\
\004\000\005\000\016\000\017\000\001\000\018\000\017\000\018\000\
\006\000\012\000\013\000\014\000\015\000\016\000\017\000\017\000\
\007\000\008\000\018\000\015\000\015\000\015\000\015\000\015\000\
\015\000\019\000\015\000\016\000\016\000\016\000\016\000\016\000\
\016\000\000\000\016\000\015\000\000\000\013\000\013\000\013\000\
\013\000\000\000\000\000\016\000\013\000\014\000\014\000\014\000\
\014\000\011\000\011\000\000\000\014\000\013\000\000\000\000\000\
\011\000\012\000\012\000\000\000\011\000\014\000\000\000\000\000\
\012\000\011\000\021\000\022\000\023\000\024\000\025\000\026\000\
\027\000\012\000\012\000\013\000\014\000\015\000\016\000\017\000\
\000\000\020\000\000\000\018\000\012\000\013\000\014\000\015\000\
\016\000\017\000\000\000\000\000\000\000\018\000\014\000\015\000\
\016\000\017\000\000\000\000\000\000\000\018\000"

let yycheck = "\001\001\
\002\001\003\001\008\001\009\001\001\000\013\001\011\001\013\001\
\010\001\004\001\005\001\006\001\007\001\008\001\009\001\020\001\
\018\001\019\001\013\001\004\001\005\001\006\001\007\001\008\001\
\009\001\020\001\011\001\004\001\005\001\006\001\007\001\008\001\
\009\001\255\255\011\001\020\001\255\255\004\001\005\001\006\001\
\007\001\255\255\255\255\020\001\011\001\004\001\005\001\006\001\
\007\001\004\001\005\001\255\255\011\001\020\001\255\255\255\255\
\011\001\004\001\005\001\255\255\006\000\020\001\255\255\255\255\
\011\001\020\001\012\000\013\000\014\000\015\000\016\000\017\000\
\018\000\020\001\004\001\005\001\006\001\007\001\008\001\009\001\
\255\255\011\001\255\255\013\001\004\001\005\001\006\001\007\001\
\008\001\009\001\255\255\255\255\255\255\013\001\006\001\007\001\
\008\001\009\001\255\255\255\255\255\255\013\001"

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
  LANGUAGE\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 24 "parser.mly"
                ( _1 )
# 157 "parser.ml"
               : Techno.tech))
; (fun __caml_parser_env ->
    Obj.repr(
# 27 "parser.mly"
                 ( TechnoInt )
# 163 "parser.ml"
               : Techno.technoType))
; (fun __caml_parser_env ->
    Obj.repr(
# 28 "parser.mly"
                 ( TechnoBool )
# 169 "parser.ml"
               : Techno.technoType))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Techno.technoType) in
    Obj.repr(
# 29 "parser.mly"
                       ( _2 )
# 176 "parser.ml"
               : Techno.technoType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 32 "parser.mly"
             ( TNum _1 )
# 183 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 33 "parser.mly"
              ( TBool true )
# 189 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 34 "parser.mly"
               ( TString _1 )
# 196 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 35 "parser.mly"
                 ( TLang _1 )
# 203 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 36 "parser.mly"
               ( TBool false )
# 209 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 37 "parser.mly"
                         ( _2 )
# 216 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 38 "parser.mly"
                      ( TPlus(_1, _3) )
# 224 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 39 "parser.mly"
                       ( TMinus(_1, _3) )
# 232 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 40 "parser.mly"
                        ( TMultiply(_1, _3) )
# 240 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 41 "parser.mly"
                       ( TDivide(_1, _3) )
# 248 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 42 "parser.mly"
                     ( TExpo(_1, _3) )
# 256 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 43 "parser.mly"
                     ( TMod(_1, _3) )
# 264 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 44 "parser.mly"
                      ( TUnion(_1, _3) )
# 272 "parser.ml"
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
