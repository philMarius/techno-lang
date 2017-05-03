![Techno Lang](small-techno-logo.png "Techno Lang")
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
(TechnoLang U TechnoLang);; => TechnoLang
```
e.g.
```
({a, b} U {x, y});; => {a, b, x, y}
```
#### Intersection
Takes two sets and outputs the set consisting of the intersection of them.
```
(TechnoLang N TechnoLang);; => TechnoLang
```
#### Concatenation
A more generic function that will take multiple inputs and output based on the input. All inputs can swap order as well.
##### Concatenation of two strings:
```
(TechnoString . TechnoString);; => TechnoString
```
  * e.g. 
```
("abc" . "xyz");; => abcxyz
```
##### Appending / prefixing of string to set:
```
(TechnoString . TechnoLang);; => TechnoLang
```
  * e.g. 
```
("a" . {x, y, z});; => {ax, ay, az}
({x, y, z} . "a");; => {xa, ya, za}
```
##### Concatenation of two sets:
```
(TechnoLang . TechnoLang);; => TechnoLang
```
  * e.g. 
```
({a, b} . {x, y});; => {ax, ay, bx, by}
```
##### Outputs a set with consisting of all variation of symbols of length TechnoInt:
```
(TechnoLang . TechnoInt);; => TechnoLang
```
  * e.g. 
```
({a, b, c} . 2);; => {aa,ab,ac,ba,bb,bc,ca,cb,cc}
```
##### String repetition:
```
(TechnoString . TechnoInt);; => TechnoString
```
  * e.g. 
```
("hello" . 2);; => hellohello
```
#### String Length
Outputs the length of a given string.
```
strlen(TechnoString);; => TechnoInt
```
e.g.
```
strlen("hello");; => 5
```
#### Cap
Caps a given set to a given size.
```
cap(TechnoInt, TechnoLang);; => TechnoLang
```
e.g.
```
cap(2, {a, b, c});; => {a, b}
```
#### Kleene Star
Produces a set consisting of the given string in kleene star form.
```
*(TechnoInt, TechnoString);; => TechnoLang
```
e.g.
```
*(4, "a");; => {:,a,aa,aaa}
```
### Deprecated Functionality
Few functions that are no longer in use but still implemented from Techno Lang 1.0.0 . It is not recommended to use them:
- `prefixToList(TechnoString, TechnoLang);; => TechnoLang` would prefix the given string to the given set.
- `concatABC(TechnoLang, TechnoInt);; => TechnoLang` would produce a set consisting of all variations of the given language of the given length.
- `postfixToList` is a broken function, do not use.
### Newlines and End of Files
- Newline: `;`
- EoF: `;;`
### Inputting files
Simple file input is implemented, pass in the file with `<` and access lines in the file using:
- `$1` for line 1
- `$last_line` for the last line in a file
## Known Bugs
A short list of known bugs that will be addressed in Techno Lang 1.2.0:
- There can only be one newline in the program or else it will fail to evaluate.
- Windows carriage return in input files cause the program to evaluate the `\r` as part of the line, e.g. will treat it as the last element in a set.
- Input files are limited to 10 lines.
- Kleene star doesn't handle the empty string in an input set correctly and can produce results such as: `{:,:b,:bb,:bbb}`.