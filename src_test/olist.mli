val reset : unit -> unit

val get : unit -> int

type 'a olist

val onil : 'a olist

val ocons : 'a -> 'a olist -> 'a olist

val map : ('a -> 'b) -> 'a olist -> 'b olist

val length : 'a olist -> int

[@@@optimize f , g , x |- map f (map g x) = map (fun x -> f (g x)) x]
