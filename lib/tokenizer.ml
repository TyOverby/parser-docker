open! Base

module Lexing = struct
  include Source_code_position
end

module Tokens = Parser

let digit = [%sedlex.regexp? '0' .. '9']

let number = [%sedlex.regexp? Plus digit]

let letter = [%sedlex.regexp? 'a' .. 'z' | 'A' .. 'Z']

let identifier =
  [%sedlex.regexp? letter, Star ('A' .. 'Z' | 'a' .. 'z' | digit)]

let rec token buf =
  match%sedlex buf with
  | "let" -> Tokens.LET
  | '=' -> Tokens.EQUAL
  | "in" -> Tokens.IN
  | '+' -> Tokens.PLUS
  | '-' -> Tokens.MINUS
  | '*' -> Tokens.TIMES
  | '/' -> Tokens.DIV
  | '(' -> Tokens.RPAREN
  | ')' -> Tokens.LPAREN
  | ";;" -> Tokens.DOUBLE_SEMICOLON
  | ';' -> Tokens.SEMICOLON
  | identifier -> Tokens.IDENT (Sedlexing.Utf8.lexeme buf)
  | white_space -> token buf
  | number -> Tokens.NUMBER (Sedlexing.Utf8.lexeme buf |> Int.of_string)
  | eof -> Tokens.EOF
  | _ -> failwith (Sedlexing.Utf8.lexeme buf)
