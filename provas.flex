import java.io.InputStreamReader;

%%

%public
%class Lexer
%unicode
%integer // yylex() returns int
%line // prefill yyline (0-based)

%{
  public static final int ID = 257;
  public static final int SUB_TYPE = 258;
  public static final int NUMBER = 259;
  public static final int OP = 260;
  public static final int LPAREN = 261;
  public static final int RPAREN = 262;
  public static final int VIRGULA = 263;
  public static final int NEWLINE = 264;

  public static void main(String argv[]) {
    Lexer scanner;
    try {
      if (argv.length == 0) {
        System.out.println("No file provided, reading from stdin");
        scanner = new Lexer(new java.io.InputStreamReader(System.in));
        while (!scanner.zzAtEOF) {
          int tk = scanner.yylex();
          if (tk == YYEOF) break;
          System.out.println(
            "token: " + tk + "\t<" + scanner.yytext() + ">\tline=" + (scanner.yyline + 1)
          );
        }
      } else {
        for (String path : argv) {
          scanner = new Lexer(new java.io.FileReader(path));
          System.out.println("Processing file: " + path);
          while (!scanner.zzAtEOF) {
            int tk = scanner.yylex();
            if (tk == YYEOF) break;
            System.out.println(
              "token: " + tk + "\t<" + scanner.yytext() + ">\tline=" + (scanner.yyline + 1)
            );
          }
        }
      }
    } catch (Exception e) {
      System.out.println("Unexpected exception:");
      e.printStackTrace();
    }
  }
%}

// ===== Macros =====
ID      = [a-zA-Z]([a-zA-Z0-9])?
INT_SUB = [0-2]
NUMBER  = [0-9]+(\.[0-9]+)?|\.[0-9]+
OP      = [+\-*/]
LPAREN  = "("
RPAREN  = ")"
VIRGULA = ","
WS      = [ \t]
NL      = \r?\n

%%

{ID}        { return ID; }
{NUMBER}    { return NUMBER; }
{INT_SUB}   { return SUB_TYPE; }
{OP}        { return OP; }
{LPAREN}    { return LPAREN; }
{RPAREN}    { return RPAREN; }
{VIRGULA}   { return VIRGULA; }
{NL}        { return NEWLINE; }
{WS}        { /* ignore whitespace */ }
.           { System.out.println((yyline+1) + ": caracter invalido: " + yytext()); }

<<EOF>>     { return YYEOF; }
