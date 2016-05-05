open Olist

let x = 1 [@@ocaml.deprecated "don't use this"]

type t = X | Y [@@ocaml.deprecated "don't use this"]

let _ =
  let y = Y in
  match y with
  | X ->
    print_string (string_of_int Triallib.x)
  | Y -> assert false
