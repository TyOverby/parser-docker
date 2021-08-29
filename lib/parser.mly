%token <int> NUMBER
%token <string> IDENT
%token PLUS MINUS TIMES DIV
%token LPAREN RPAREN
%token SEMICOLON
%token LET EQUAL IN
%token EOF

%nonassoc IN
%nonassoc LET
%left PLUS MINUS
%left TIMES DIV
%nonassoc UMINUS

%start <Ast.Expr.t Ast.Spanned.t list> main

%{
open Ast
%}

%%

main:
| stmt = expr SEMICOLON? EOF { [stmt] }
| stmt = expr SEMICOLON m = main { stmt :: m}

pattern: 
| ident = IDENT { spanned ~span:$loc (Pattern.Ident (spanned ~span:$loc ident))}

expr:
| i = NUMBER { spanned ~span:$loc (Expr.Int_lit (spanned ~span:$loc i)) }
| ident = IDENT { spanned ~span:$loc (Expr.Ident (spanned ~span:$loc ident)) }
| LPAREN e = expr RPAREN
    { spanned ~span:$loc (Expr.Parens e) }
| e1 = expr PLUS e2 = expr
    { spanned ~span:$loc (Expr.Add (e1, e2)) }
| e1 = expr MINUS e2 = expr
    { spanned ~span:$loc (Expr.Sub (e1, e2)) }
| e1 = expr TIMES e2 = expr
    { spanned ~span:$loc (Expr.Mul (e1, e2)) }
| e1 = expr DIV e2 = expr
    { spanned ~span:$loc (Expr.Div (e1, e2)) }
| LET binding = pattern EQUAL rhs = expr IN body = expr 
    { spanned ~span:$loc (Expr.Let 
      {
      binding; 
      rhs; 
      body; 
    }) }
| MINUS e = expr %prec UMINUS
    { spanned ~span:$loc (Expr.Neg e) }