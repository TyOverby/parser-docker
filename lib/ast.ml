open! Base

module Spanned = struct
  let all :
      (Caml.Obj.t * (Source_code_position.t * Source_code_position.t)) list ref
      =
    ref []

  let register a ~span =
    all := (Caml.Obj.repr a, span) :: !all;
    a

  let find a = List.Assoc.find !all ~equal:phys_equal (Caml.Obj.repr a)

  let copy ~from ~to_ =
    let span = find from |> Option.value_exn in
    register to_ ~span
end

module rec Top_level : sig
  type t = Value of { name : string; expr : Expr.t } [@@deriving sexp_of]
end = struct
  type t = Value of { name : string; expr : Expr.t } [@@deriving sexp_of]
end

and Pattern : sig
  type t = Ident of string [@@deriving sexp_of]
end = struct
  type t = Ident of string [@@deriving sexp_of]
end

and Expr : sig
  type t =
    | Int_lit of int
    | Ident of string
    | Add of t * t
    | Sub of t * t
    | Mul of t * t
    | Div of t * t
    | Ignore of t * t
    | Parens of t
    | Neg of t
    | Let of { binding : Pattern.t; rhs : t; body : t }
  [@@deriving sexp_of]
end = struct
  type t =
    | Int_lit of int
    | Ident of string
    | Add of t * t
    | Sub of t * t
    | Mul of t * t
    | Div of t * t
    | Ignore of t * t
    | Parens of t
    | Neg of t
    | Let of { binding : Pattern.t; rhs : t; body : t }
  [@@deriving sexp_of]
end

let spanned item ~span = Spanned.register item ~span
