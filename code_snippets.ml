*********ignore**************
(***********Set Union************)

let union list1 list2 list3 =
	let rec combine n = function
		| [] -> n
		|

****Only works with numbers, and I stole off the internet lol*************
let rec intersect l1 l2 =
    match l1 with [] -> []
        | h1::t1 -> (
          match l2 with [] -> []
              | h2::t2 when h1 < h2 -> intersect t1 l2
              | h2::t2 when h1 > h2 -> intersect l1 t2
              | h2::t2 -> (
                match intersect t1 t2 with [] -> [h1]
                    | h3::t3 as l when h3 = h1 -> l
                    | h3::t3 as l -> h1::l
              )
        );;
intersect [1; 2; 5; 7] [2; 3; 5; 6; 9; 7];;

************************************************************************
************************************************************************
************************************************************************

(* function to add an element to a list using ocaml methods*)

let add list elem =
	list@[elem];;


add [1 ; 2 ; 3] 4;;       (* returns [1; 2; 3; 4] *)


(*Function to remove an element from a list using own methods*)
let remove list elem =
	let rec aux l2 = function
		| [] -> rev l2
		| h::t -> if h = elem then aux l2 t else aux (h::l2) t
	in aux [] list;;

(* function to reverse a list using own methods*)
let rev list =
    let rec aux acc = function
      | [] -> acc
      | h::t -> aux (h::acc) t in
    aux [] list;;

remove [1; 2; 3; 4] 3;;     (* returns [1; 2; 4] *)


(* function to combine lists using ocaml methods *)
let combine l1 l2 =
	l1@l2;;

combine [1; 2; 3] [3; 4; 5];;


(* function to combine lists with own methods *)
let append l1 l2 =
	let rec aux l3 = function
		| [] -> l3
		| h::t -> aux (h::l3) t in
	aux l1 l2;;

append [1; 2; 3] [3; 4; 5];;                       (* returns [5; 4; 3; 1; 2; 3] *)
append ["a"; "b"; "c"; "d"] ["d"; "e"; "f"];;



(* removes duplicates from a list *)
let removeDuplicates l1 =
	let rec aux l2 = function
		| [] -> rev l2
		| h :: t -> if List.mem h l2 then aux l2 t else aux (h :: l2) t
	in aux [] l1;;

removeDuplicates [1; 2; 3; 3; 4; 2; 5; 9; 1];;    (* returns [1; 2; 3; 4; 5; 9] *)
removeDuplicates ["a"; "b" ; "a" ; "d"];;


let union l1 l2 =
	removeDuplicates (append l1 l2);;

union [1; 2; 3; 4; 5] [2; 6];;        (* returns [6; 2; 1; 3; 4; 5] *)


(* returns the intersection of two lists *)
let getIntersection l1 l2 =
	let rec aux l3 = function
		| [] -> l3
		| h :: t -> if List.mem h l1 && List.mem h l2 then aux (h::l3) t else aux l3 t in
	aux [] l1;;


getIntersection [1; 2; 3; 4] [4; 5; 6; 1];;             (* returns [4; 1] *)
getIntersection ["a"; "b"] ["b"];;





let lettersToNumbers l1 =
	let rec aux l2 = function
		| [] -> l2
		| h :: t -> if h = "a" then aux (1 :: l2) t else
					if h = "b" then aux (2 :: l2) t else
					if h = "c" then aux (3 :: l2) t else
					if h = "d" then aux (4 :: l2) t else
					if h = "e" then aux (5 :: l2) t else
					if h = "f" then aux (6 :: l2) t else
					if h = "g" then aux (7 :: l2) t else
					if h = "h" then aux (8 :: l2) t else
					if h = "i" then aux (9 :: l2) t else
					if h = "j" then aux (10 :: l2) t else
					if h = "k" then aux (11 :: l2) t else
					if h = "l" then aux (12 :: l2) t else
					if h = "m" then aux (13 :: l2) t else
					if h = "n" then aux (14 :: l2) t else
					if h = "o" then aux (15 :: l2) t else
					if h = "p" then aux (16 :: l2) t else
					if h = "q" then aux (17 :: l2) t else
					if h = "r" then aux (18 :: l2) t else
					if h = "s" then aux (19 :: l2) t else
					if h = "t" then aux (20 :: l2) t else
					if h = "u" then aux (21 :: l2) t else
					if h = "v" then aux (22 :: l2) t else
					if h = "w" then aux (23 :: l2) t else
					if h = "x" then aux (24 :: l2) t else
					if h = "y" then aux (25 :: l2) t else
					if h = "z" then aux (26 :: l2) t else
					aux l2 t
	in aux [] l1;;



lettersToNumbers ["a"; "c"; "hello"];;


(*Converts a letter to alphabetical number *)
let lettersToNumbers = function
	| ":" -> 0
	| "a" -> 1
	| "b" -> 2
	| "c" -> 3
	| "d" -> 4
	| "e" -> 5
	| "f" -> 6
	| "g" -> 7
	| "h" -> 8
	| "i" -> 9
	| "j" -> 10
	| "k" -> 11
	| "l" -> 12
	| "m" -> 13
	| "n" -> 14
	| "o" -> 15
	| "p" -> 16
	| "q" -> 17
	| "r" -> 18
	| "s" -> 19
	| "t" -> 20
	| "u" -> 21
	| "v" -> 22
	| "w" -> 23
	| "x" -> 24
	| "y" -> 25
	| "z" -> 26;;


lettersToNumbers "q";;

(* converts single letters into numbers ready for sorting *)
let convertToNumbers l1 =
	let rec aux l2 = function
		| [] -> l2
		| h :: t -> aux ((lettersToNumbers h) :: l2) t
	in aux [] l1;;

convertToNumbers ["a"; "b"; "c"; "b"];;


(* adds an element to a list in numerical order *)
let rec orderNumerically n l1 =
	match l1 with
		| [] -> [n]
		| h :: t -> if n < h then n :: h :: t else h :: orderNumerically n t;;


(* sorts a list into numerical order *)
let sorter l1 =
	let rec aux l2 = function
		| [] -> l2
		| h :: t -> aux (orderNumerically h l2) t
	in aux [] l1;;


sorter [1; 3; 5; 6; 4; 1 ; 1; 9; 7; 2];;       (* returns [1;1;1;2;3;4;5;6;7;9] *)



let numbersToLetters = function
	| 0 -> ":"
	| 1 -> "a"
	| 2 -> "b"
	| 3 -> "c"
	| 4 -> "d"
	| 5 -> "e"
	| 6 -> "f"
	| 7 -> "g"
	| 8 -> "h"
	| 9 -> "i"
	| 10 -> "j"
	| 11 -> "k"
	| 12 -> "l"
	| 13 -> "m"
	| 14 -> "n"
	| 15 -> "o"
	| 16 -> "p"
	| 17 -> "q"
	| 18 -> "r"
	| 19 -> "s"
	| 20 -> "t"
	| 21 -> "u"
	| 22 -> "v"
	| 23 -> "w"
	| 24 -> "x"
	| 25 -> "y"
	| 26 -> "z";;


let convertToLetters l1 =
	let rec aux l2 = function
		| [] -> List.rev l2
		| h :: t -> aux ((numbersToLetters h) :: l2) t
	in aux [] l1;;


convertToLetters [1; 3; 5; 6; 7; 8; 9];;


**************depricated*************************
let alphabet l1 =
	convertToLetters(sorter(convertToNumbers(l1)));;




(* sort alphabetically *)
let alphabet l1 =
	List.sort String.compare l1;;

alphabet ["c" ; "d" ; "a" ; "b"];;



*****HOW TO GUIDE*********
call the function you want, eg union or get intersection, these handle duplicates
then with the returned list, call alphabet on it and it'll sort them into alphabetical order (only works on individual chars atm)