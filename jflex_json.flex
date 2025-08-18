import java.io.InputStreamReader;

%%
%public
%class jsonlex
%unicode
%integer // yylex() returns int
%line // prefill yyline (0-based)

%{
  // Token codes for non-ASCII tokens (>=256 to avoid collision with single chars)
  public static final int STRING = 257;
  public static final int NUMBER = 258;

  public static void main(String argv[]) {
    jsonlex scanner;
    try {
      if (argv.length == 0) {
        scanner = new jsonlex(new InputStreamReader(System.in));
        while (!scanner.zzAtEOF) {
          int tk = scanner.yylex();
          if (tk == YYEOF) break;
          System.out.println(
            "token: " + tk + "\t<" + scanner.yytext() + ">\tline=" + (scanner.yyline + 1)
          );
        }
      } else {
        for (String path : argv) {
          scanner = new jsonlex(new java.io.FileReader(path));
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
DIGIT = [0-9]
INT = 0|[-]?[1-9]{DIGIT}* // Allow negative integers
FRAC = \.{DIGIT}+
EXP = [eE][+-]?{DIGIT}+
NUMBER_RE = [-]?{INT}({FRAC})?({EXP})? 
ESCAPE = \\([\"\\\/bfnrt]|u[0-9a-fA-F]{4}) 
STRING_RE = \"({ESCAPE}|[^\"\\])*\" 
WHITESPACE = [ \t\f]+
LineTerminator = \r\n|\n|\r

%%
","|":"|"{"|"}"|"["|"]" { return yytext().charAt(0); }

{NUMBER_RE} { return NUMBER; }

{STRING_RE} { return STRING; }

{WHITESPACE}+ { /* skip */ }

{LineTerminator}+ { /* skip */ }

// Invalid characters
. { System.out.println((yyline+1) + ": caracter invalido: " + yytext()); }

// End of file
<<EOF>> { return YYEOF; }