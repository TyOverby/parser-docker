open! Base 

let%expect_test _ =
  Stdio.print_endline "Hello world!";
  [%expect{|
    Hello world!
  |}]
