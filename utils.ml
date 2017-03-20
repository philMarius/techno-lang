exception EmptyListError;;

open Str;;

(*==== Utilities functions ====*)

(* Append to end of a list *)
let append l1 l2 =
	let rec aux l3 = function
		| [] -> l3
		| h::t -> aux (h::l3) t in
	aux l1 l2
;;

(* Remove the right curly braces *)
let rm_rparen s =
	Str.global_replace (Str.regexp "{") "" s
;;

(* Remove the left curly braces *)
let rm_lparen s =
	Str.global_replace (Str.regexp "}") "" s
;;

(* Sort and remove duplicates *)
let uniq_sort l =
	let sort = List.sort compare l in
	let rec aux l2 = function
		| [] -> List.rev l2
		| h :: t -> if (List.mem h l2) then aux l2 t else aux (h :: l2) t
	in List.sort compare (aux [] sort)
;;

(* Convert string form of set to list *)
let str_to_lst str =
	let rm_paren str =
		rm_lparen (rm_rparen str)
	in uniq_sort (Str.split (Str.regexp ",") (rm_paren str))
;;

(* Union of two sets *)
let union l1 l2 =
	uniq_sort (append l1 l2)
;;

(* Different union function *)
let union2 l1 l2 =
	uniq_sort (List.merge compare l1 l2)
;;

(* Intersection of two sets *)
let rec intersect l1 l2 =
    match l1 with [] -> []
        | h1::t1 -> (
          match l2 with
							| [] -> []
              | h2::t2 when h1 < h2 -> intersect t1 l2
              | h2::t2 when h1 > h2 -> intersect l1 t2
              | h2::t2 -> (
                match intersect t1 t2 with
										| [] -> [h1]
                    | h3::t3 as l when h3 = h1 -> l
                    | h3::t3 as l -> h1::l
              )
        );;

(* Convert list to string form of set *)
let lst_to_str l =
	"{"^String.concat ", " (uniq_sort l)^"}"
;;

(* Remove quotes from the string *)
let rm_quotes s =
  Str.global_replace (Str.regexp "\"") "" s
;;

(* Add quotes back to the string *)
let add_quotes s =
  "\""^s^"\""
;;

(* Generate string of length l comprised of string n    --> Use String.make *)
let gen_str l n =
	let rec aux l n acc =
		if n>0 then aux l (n-1) acc ^ l else ""
  in aux l n "";;

(* Generate list of length n of  *)
let kleene n l1 =
	let rec aux x l2 = function
		| [] -> l2
		| h::t -> if x < n then aux (x+1) ((h^(gen_str "a" x)) :: l2) l1 else List.rev l2
  in aux 0 [] l1
;;

(* Take letter n and concatenate it with every element in list l2 *)
let append_letter_to_list n l2 =
  let destring x = if (String.contains x '\"') then (rm_quotes x) else x in
  let rec aux l3 = function
    | [] -> List.rev l3
    | h::t -> aux (((destring n)^h)::l3) t
  in aux [] l2;;

(* Limit length of list l1 to length n *)
let limit_list_length n l1 =
  let rec aux x l2 = function
    | [] -> l2
    | h :: t -> if x < n then aux (x + 1) (h :: l2) t else List.rev l2
  in aux 0 [] l1
;;

(*  *)
let concat2 n l1 =
  let rec aux = function
    | [] -> []
    | h :: t -> limit_list_length n (append_letter_to_list h ["aa"; "ab"; "ac"; "ba"; "bb"; "bc"; "ca"; "cb"; "cc"; "aaa"; "aab"; "aac"; "aba"; "abb"; "abc"; "aca"; "acb"; "acc"; "baa";"bab";"bac";"bba";"bbb";"bbc";"bca";"bcb";"bcc";"caa";"cab";"cac";"cba";"cbb";"cbc";"cca";"ccb";"ccc";"aaaa";"aaab";"aaac";"aaba"])
  in aux l1
;;

let stream_of_channel channel =
  Stream.from
    (fun _ ->
      try Some (input_line channel) with End_of_file -> None)
;;

let gen_list stream_npeek =
	let rec aux list peek =
		match peek with
		| [] -> list
		| h :: t -> aux (h :: list) t
	in aux [] stream_npeek
;;

let rec last_element = function
  | [x] -> x
  | _ :: t ->  last_element t
  | [] -> raise EmptyListError
;;

let rm_dollar =
  Str.global_replace (Str.regexp "$") ""
;;

let input_file = stream_of_channel stdin;;

let get_line ln =
  last_element (Stream.npeek (int_of_string ln) input_file)
;;

let get_last_line =
  (int_of_string (last_element (Stream.npeek 100 input_file)))
;;

type 'a list = Nil | Cons of 'a * 'a list;;
type 'a stream = Nil | Cons of 'a * (unit -> 'a stream);;

let hd s =
  match s with
  | Nil -> failwith "hd"
  | Cons (x, _) -> x

let tl s =
  match s with
  | Nil -> failwith "tl"
  | Cons (_, g) -> g ()
;;

let nth ln =
	let rec aux n stream =
  	if n = 0 then hd stream else aux (n - 1) (tl stream)
	in aux (int_of_string (rm_dollar ln)) input_file
;;
