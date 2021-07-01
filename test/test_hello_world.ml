open! Base 

let%expect_test _ =
  Hello_world.print_hello_world ();
  [%expect{|
    Hello world!
  |}]
