open Ocamlbuild_plugin

let () = dispatch (fun phase ->
  match phase with
  | After_rules ->
    flag ["ocaml"; "compile"; "ppx_byte"] &
      S[A"-ppx"; A"src/ppx_rewrite.byte"];
    flag ["ocaml"; "compile"; "ppx_native"] &
      S[A"-ppx"; A"src/ppx_rewrite.native"]
  | _ -> ())
