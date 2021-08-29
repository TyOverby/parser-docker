open! Base

let%expect_test _ =
  Hello_world.print_hello_world ();
  [%expect
    {|
    Ident foobar
    Ident A123Bfoo
    Op ++
    Number 123
    Ident Xbar
    Op /
    Ident foo
    EOF
  |}]
