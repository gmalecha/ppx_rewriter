open Olist
open OUnit

let test_map_fusion _ =
  reset () ;
  let x = ocons 3 onil in
  let _ = map (fun x -> x) (map (fun x -> x) x) [@rewrite "optimize"] in
  assert_equal 1 (get ())

let suite = "Test ppx_rewrite" >::: [
    "test_ppx_rewrite" >:: test_map_fusion
  ]

let _ =
  run_test_tt_main suite
