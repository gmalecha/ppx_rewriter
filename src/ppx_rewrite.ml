open Ast_mapper
open Ast_helper
open Asttypes
open Parsetree
open Longident

let is_optimize = function
    ({ txt = "rewrite" ; loc },
     PStr [%str "optimize"]) -> true
  | _ -> false

let rec rewrite = function
  [%expr map [%e? f1 ] (map [%e? f2] [%e? ls])] ->
    [%expr map (fun x -> [%e f1] ([%e f2] x)) [%e ls]]
  | x -> x


let optimize_mapper argv =
  { Ast_mapper.default_mapper with
    Ast_mapper.signature_item =
    begin fun mapper si ->
      match si with
      (* Is this an extension node? *)
      | { psig_desc =
          (* Should have name "getenv". *)
          Psig_extension (({ txt = "rewrite" ; loc }, pay), _) } ->
        begin match pay with
              | PStr _ -> raise (Location.Error (Location.error ~loc "str"))
              | PTyp _ -> raise (Location.Error (Location.error ~loc "type"))
              | PPat (_,_) -> raise (Location.Error (Location.error ~loc "pat"))
              | PSig _ -> raise (Location.Error (Location.error ~loc "sig"))
        end
      (* Delegate to the default mapper. *)
      | x -> default_mapper.signature_item mapper x
    end
  ; Ast_mapper.expr =
    begin fun mapper expr ->
      if List.exists is_optimize expr.pexp_attributes
      then
        rewrite expr
      else
        default_mapper.expr mapper expr
    end
  }

let () = register "optimize" optimize_mapper
