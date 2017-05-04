# ![](small-techno-logo.png "Techno Lang") Techno Lang v1.1.0
Why use many lines when one will do?

## About
Simplistic set manipulation language interpreter built using OCaml.
## Authors
- [Phil](https://github.com/philMarius)
- [James](https://github.com/jameslinwood)
## Installing from source
### Dependencies
#### All installations
- [OCaml](http://ocaml.org/)
#### Further Windows installations
- [Bash on Ubuntu on Windows](https://msdn.microsoft.com/en-gb/commandline/wsl/install_guide)
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
### Running the interpreter
- To interpret one file with no inputs: `./mysplinterpreter <PROGRAM NAME>.spl`
- To interpret one file with one input: `./mysplinterpreter <PROGRAM NAME>.spl < <INPUT FILENAME>`
## The Language
### Types
#### TechnoLang
Represents a language or a set of symbols. Can include numbers and symbols but all elements of a TechnoLang is treated as a standalone symbol.
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
({a, b} U {x, y});; => {a, b, x, y}
```
#### Intersection
Takes two sets and outputs the set consisting of the intersection of them.
```
(TechnoLang N TechnoLang);; => TechnoLang
({a, b, c} N {b, c, d});; => {b, c}
```
#### Concatenation
A more generic function that will take multiple inputs and output based on the input. All inputs can swap order as well.
##### Concatenation of two strings:
```
(TechnoString . TechnoString);; => TechnoString
("abc" . "xyz");; => abcxyz
```
##### Appending / prefixing of string to set:
```
(TechnoString . TechnoLang);; => TechnoLang
("a" . {x, y, z});; => {ax, ay, az}
({x, y, z} . "a");; => {xa, ya, za}
```
##### Concatenation of two sets:
```
(TechnoLang . TechnoLang);; => TechnoLang
({a, b} . {x, y});; => {ax, ay, bx, by}
```
##### Outputs a set with consisting of all variation of symbols of length TechnoInt:
```
(TechnoLang . TechnoInt);; => TechnoLang
({a, b, c} . 2);; => {aa,ab,ac,ba,bb,bc,ca,cb,cc}
```
##### String repetition:
```
(TechnoString . TechnoInt);; => TechnoString
("hello" . 2);; => hellohello
```
#### String Length
Outputs the length of a given string.
```
strlen(TechnoString);; => TechnoInt
strlen("hello");; => 5
```
#### Cap
Caps a given set to a given size.
```
cap(TechnoInt, TechnoLang);; => TechnoLang
cap(2, {a, b, c});; => {a, b}
```
#### Kleene Star
Produces a set consisting of the given string in kleene star form.
```
*(TechnoInt, TechnoString);; => TechnoLang
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
Access lines in a given command line argument file using:
- `$1` for line 1, `$2` for line 2 etc.
- `$last_line` for the last line in a file
### Error Messages
Only very simplistic error messages are currently implemented in TechnoLang. Passing in the wrong arguments into a given function will alert the user as to what the error is. All current and deprecated functionality has this exception raising functionality.

e.g.
```
(4 U "hello");; => Fatal error: exception Techno.TypeError("Input type to union is not of TechnoLang type")
```
## Known Issues
A short list of known bugs that will be addressed in Techno Lang v1.2.0:
- There can only be one newline in the program or else it will fail to execute.
- Windows carriage return in input files cause the program to evaluate the `\r` as part of the line, i.e. will treat it as the last element in a set.
- Input files are limited to 10 lines.
- Kleene star doesn't handle the empty string in an input set correctly and can produce results such as: `{:,:b,:bb,:bbb}`.
- Techno Lang doesn't handle floats
- Techno Lang has ambigious error messages
- Techno Lang lacks variable functionality, looping and environments (would have loved to make this Turing Complete)
- The interpreter fails to run on Windows OCaml installations, requires Bash on Windows to run
## Appendices and further examples of code