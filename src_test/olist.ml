let counter = ref 0

let reset () = counter := 0

let get () = !counter

type 'a olist =
    Onil
  | Ocons of 'a * 'a olist

let onil = Onil

let ocons a b = Ocons (a,b)

let map f x =
  counter := !counter + 1 ;
  let rec map = function
      Onil -> Onil
    | Ocons (a,b) -> Ocons (f a, map b)
  in map x

let rec length = function
    Onil -> 0
  | Ocons (_,ls) -> 1 + length ls
