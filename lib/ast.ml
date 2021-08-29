open! Base

module Spanned = struct
  type 'a t = {
    span : Source_code_position.t * Source_code_position.t;
    item : 'a;
  } [@@deriving sexp_of]
end

module rec Pattern : sig
  type t = Ident of string Spanned.t [@@deriving sexp_of]
end = struct 
  type t = Ident of string Spanned.t [@@deriving sexp_of]
end
and Expr : sig
  type t =
    | Int_lit of int Spanned.t
    | Ident of string Spanned.t
    | Add of t Spanned.t * t Spanned.t
    | Sub of t Spanned.t * t Spanned.t
    | Mul of t Spanned.t * t Spanned.t
    | Div of t Spanned.t * t Spanned.t
    | Parens of t Spanned.t
    | Neg of t Spanned.t
    | Let of {
        binding : Pattern.t Spanned.t;
        rhs : t Spanned.t;
        body : t Spanned.t;
      } [@@deriving sexp_of]
end = struct 
  type t =
    | Int_lit of int Spanned.t
    | Ident of string Spanned.t
    | Add of t Spanned.t * t Spanned.t
    | Sub of t Spanned.t * t Spanned.t
    | Mul of t Spanned.t * t Spanned.t
    | Div of t Spanned.t * t Spanned.t
    | Parens of t Spanned.t
    | Neg of t Spanned.t
    | Let of {
        binding : Pattern.t Spanned.t;
        rhs : t Spanned.t;
        body : t Spanned.t;
      } [@@deriving sexp_of]
end

let spanned item ~span = { Spanned.item; span }
