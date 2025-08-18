# 📘 Instruções de uso do analisador léxico com JFlex

## 1. Gerar o analisador léxico
Utilize o **JFlex** para transformar o arquivo `.flex` em um arquivo Java (classe do analisador):

```bash
java -jar JFlex.jar arquivo.flex
```

👉 Esse comando vai gerar automaticamente o arquivo `arquivo.java`.

---

## 2. Compilar o analisador léxico
Depois, compile o arquivo `.java` gerado pelo JFlex:

```bash
javac arquivo.java
```

👉 Esse comando cria o `arquivo.class`, que é o bytecode executável do analisador.

---

## 3. Executar o analisador
Por fim, rode o analisador passando o arquivo de entrada que você quer testar (ex: `Pessoa.java`):

```bash
java -cp . arquivo Pessoa.java
```
```bash
java -cp . Lexer.java test.txt
```

- `-cp .` garante que o Java procure a classe no diretório atual (`.`).  
- `arquivo` é o nome da classe gerada.  
- `Pessoa.java` é o arquivo de entrada a ser analisado (pode trocar por qualquer outro).

---

⚠️ Observação: certifique-se de que:
- O **nome da classe** dentro do `.flex` (`%class arquivo`) é o mesmo que você usa no comando `java ...`.
- O `.flex`, o `.java` gerado, o `.class` compilado e o arquivo de teste (`Pessoa.java`) estejam no **mesmo diretório** quando você executar os comandos.
