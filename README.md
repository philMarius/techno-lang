# Techno Lang 1.1.0
The minimalist, extensible set theory language built for ease of use.
## Authors
- [Phil](https://github.com/philMarius)
- [James](https://github.com/jameslinwood)
## Installating from source
### Dependencies
- [OCaml](http://ocaml.org/)
### Installation
Use the `make` command to compile the interpreter. Expected output:
```
$ make
ocamllex lexer.mll
76 states, 704 transitions, table size 3272 bytes
ocamlyacc -v parser.mly
ocamlc -c Techno.mli
ocamlc -c parser.mli
ocamlc -c parser.ml
ocamlc -c Techno.ml
File "Techno.ml", line 289, characters 4-5:
Warning 11: this match case is unused.
ocamlc -c lexer.ml
File "lexer.mll", line 14, characters 24-77:
Warning 8: this pattern-matching is not exhaustive.
Here is an example of a value that is not matched:
[]
ocamlc -c mysplinterpreter.ml
Linking mysplinterpreter
ocamlc -o mysplinterpreter str.cma parser.cmo lexer.cmo Techno.cmo mysplinterpreter.cmo
$
```
## The Language
### Types
#### TechnoLang
Represents a language or a set of symbols.
```
{a, b, c, d} => TechnoLang
```
#### TechnoString
Represents a string in literal form.
```
"string" => TechnoString
```
#### TechnoInt
Represents a number in integer form.
```
123 => TechnoInt
```
### Current Functionality
Note: all functions that output a set will automatically order them in alphabetical order and remove any duplicates.
#### Union
Takes two sets and outputs the set consisting of the union of them.
```
(TechnoLang U TechnoLang) => TechnoLang
```
e.g.
```
({a, b} U {x, y}) => {a, b, x, y}
```
#### Intersection
Takes two sets and outputs the set consisting of the intersection of them.
```
(TechnoLang N TechnoLang) => TechnoLang
```
#### Concatenation
A more generic function that will take multiple inputs and output based on the input. All inputs can swap order as well.
- Concatenation of two strings:
```
(TechnoString . TechnoString) => TechnoString
```
e.g. 
```
("abc" . "xyz") => "abcxyz"
```
- Appending / prefixing of string to set:
```
(TechnoString . TechnoLang) => TechnoLang
```
e.g. 
```
("a" . {x, y, z}) => {ax, ay, az}
({x, y, z} . "a") => {xa, ya, za}
```
- Concatenation of two sets:
```(TechnoLang . TechnoLang) => TechnoLang```
e.g.
`({a, b} . {x, y}) => {ax, ay, bx, by}`
- 
`(TechnoLang . TechnoInt) => TechnoLang`
`(TechnoString . TechnoIng) => TechnoString`
### Deprecated Functionality
## Examples
## Known Bugs
