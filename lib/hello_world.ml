open! Base
module Tokenizer = Tokenizer
module Parser = Parser

let ast_of_string string =
  let lexbuf = Sedlexing.Utf8.from_string string in
  let next = Sedlexing.with_tokenizer Tokenizer.token lexbuf in
  let revised_parser =
    MenhirLib.Convert.Simplified.traditional2revised Parser.main
  in
  revised_parser next

let print_hello_world () =
  let ast =
    ast_of_string
      {|
  let a = 
    let b = 5 * 10 in 
    b + 2
  ;;
  let b = a;;
|}
  in
  ast |> [%sexp_of: Ast.Top_level.t list] |> Sexp.to_string_hum
  |> Stdio.print_endline
