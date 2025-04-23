//
// Parser for SimpleC programs.  This component checks 
// the input program to see if it meets the syntax rules
// of SimpleC.  The parser returns a string denoting
// success or failure. 
//
// Returns: the string "success" if the input program is
// legal, otherwise the string "syntax_error: ..." is
// returned denoting an invalid SimpleC program.
//
// John Ezra See
//
// Original author:
//   Prof. Joe Hummel
//   U. of Illinois, Chicago
//   CS 341, Spring 2022
//

namespace compiler

module parser =

  // Helper function
  let beginswith (pattern: string) (literal: string) =
    literal.StartsWith pattern

  //
  // matchToken
  //
  let private matchToken expected_token tokens =
    //
    // if the next token matches the expected token,  
    // keep parsing by returning the rest of the tokens.
    // Otherwise throw an exception because there's a 
    // syntax error, effectively stopping compilation
    // at the first error.
    //
    let next_token = List.head tokens
    if expected_token = "str_literal:" then
      List.tail tokens
    else if expected_token = "int_literal:" then
      List.tail tokens
    else if expected_token = next_token then  
      List.tail tokens
    else
      failwith ("expecting " + expected_token + ", but found " + next_token)

  // We use a helper function for identifiers.
  // This is probably not necessary - as we can do it expr-value
  let private matchIdentifier tokens = 
    let next_token = List.head tokens
    if beginswith "identifier" next_token then 
      List.tail tokens
    else // return a fail if we don't find an identifier
      failwith ("expecting identifier, but found " + next_token)

  //
  // simpleC
  // (only use keyword rec here - the following can be "and" (rec is implied already))
  // <simpleC> -> void main ( ) { <stmts> } $
  let rec private simpleC tokens = 
    // entry point
    let T1 = matchToken "void" tokens
    let T2 = matchToken "main" T1
    let T3 = matchToken "(" T2
    let T4 = matchToken ")" T3
    let T5 = matchToken "{" T4
    let T6 = stmts T5
    let T7 = matchToken "}" T6
    let T8 = matchToken "$" T7
    T8

  // <stmts> -> <stmt> <morestmts>
  and private stmts tokens = 
    let T1 = stmt tokens
    morestmts T1

  // <stmt> -> <empty>
  //  | <vardecl>
  //  | <input>
  //  | <output>
  //  | <assignment>
  //  | <ifstmt>
  and private stmt tokens = 
    let next_token = List.head tokens
    if next_token = ";" then
      empty tokens
    else if next_token = "int" then 
      vardec1 tokens
    else if next_token = "cin" then
      input tokens
    else if next_token = "cout" then
      output tokens
    else if beginswith "identifier:" next_token then
      assignment tokens 
    else if next_token = "if" then 
      ifstmt tokens
    else
      failwith ("expecting statement, but found " + next_token) 

  // <morestmts> -> <stmt> <morestmts>
  //  | EMPTY
  and private morestmts tokens = 
    let next_token = List.head tokens
    if next_token = "}" then // This is a bit ambiguous...
      tokens
    else 
      let T1 = stmt tokens
      morestmts T1

  // <condition> -> <expr>
  and private condition tokens =
    expr tokens

  // <then-part> -> <stmt>
  and private then_part tokens = 
    stmt tokens

  // <else-part> -> else <stmt>
  //  | EMPTY
  and private else_part tokens = 
    let next_token = List.head tokens
    if next_token = "else" then
      let T1 = matchToken "else" tokens
      let T2 = stmt T1
      T2
    else 
      tokens

  // <ifstmt> -> if ( <condition> ) <then-part> <else-part>
  and private ifstmt tokens = 
    let T1 = matchToken "if" tokens
    let T2 = matchToken "(" T1
    let T3 = condition T2
    let T4 = matchToken ")" T3
    let T5 = then_part T4
    let T6 = else_part T5
    T6

  // <input> -> cin >> identifier;
  and input tokens = 
    let T1 = matchToken "cin" tokens
    let T2 = matchToken ">>" T1
    let T3 = matchIdentifier T2
    let T4 = matchToken ";" T3
    T4

  // <expr-value> -> identifier
  //  | int_literal
  //  | str_literal
  //  | true
  //  | false
  and expr_value tokens = 
    let next_token = List.head tokens

    if beginswith "str_literal:" next_token then 
      matchToken "str_literal:" tokens
    else if beginswith "int_literal:" next_token then
      matchToken "int_literal:" tokens
    else if next_token = "false" then
      matchToken "false" tokens
    else if next_token = "true" then
      matchToken "true" tokens
    else if beginswith "identifier:" next_token then
      matchIdentifier tokens
    else 
      failwith ("expecting identifier or literal, but found " + next_token)

  // <output-value> -> <expr-value>
  //  | endl
  and private output_value tokens = 
    let next_token = List.head tokens
    if next_token = "endl" then
      matchToken "endl" tokens
    else
      expr_value tokens

  // <output> -> cout << <output-value> ;
  and private output tokens = 
    let T1 = matchToken "cout" tokens
    let T2 = matchToken "<<" T1
    let T3 = output_value T2
    matchToken ";" T3

  // ;
  and private empty tokens = 
    matchToken ";" tokens

  // <assignment> -> identifier = <expr> ;
  and private vardec1 tokens = 
    let T1 = matchToken "int" tokens
    let T2 = matchIdentifier T1
    let T3 = matchToken ";" T2
    T3

  // <expr-op> -> +
  //  | -
  //  | *
  //  | /
  //  | ^
  //  | <
  //  | <=
  //  | >
  //  | >=
  //  | ==
  //  | !=
  and private expr_op tokens = 
    let next_token = List.head tokens
    if next_token = "+" || next_token = "-" || next_token = "*" || next_token = "/" || next_token = "^"
        || next_token = "<" || next_token = "<=" || next_token = ">" || next_token = ">=" 
        || next_token = "==" || next_token = "!=" then
        matchToken next_token tokens
    else
        failwith ("expecting expression operator, but found " + next_token)

  // <expr> -> <expr-value> <expr-op> <expr-value>
  //  | <expr-value>
  and private expr tokens = 
    let T1 = expr_value tokens
    
    if List.isEmpty T1 then // base case: if it's empty, then just <expr-value>
      T1
    else 
        let next_token = List.head T1 
        let isOp = next_token = "+" || next_token = "-" || next_token = "*" || next_token = "/" || next_token = "^" || next_token = "<" || next_token = "<=" || next_token = ">" || next_token = ">=" || next_token = "==" || next_token = "!="
        if isOp then
            // long expression
            let T2 = expr_op T1
            let T3 = expr_value T2
            T3
        else // otherwise, just <expr-value> 
            T1

  // <assignment> -> identifier = <expr> ; 
  and private assignment tokens =
    let T1 = matchIdentifier tokens
    let T2 = matchToken "=" T1
    let T3 = expr T2
    let T4 = matchToken ";" T3
    T4

  //
  // parse tokens
  //
  // Given a list of tokens, parses the list and determines
  // if the list represents a valid SimpleC program.  Returns
  // the string "success" if valid, otherwise returns a 
  // string of the form "syntax_error:...".
  //
  let parse tokens = 
    try
      let result = simpleC tokens
      "Success!"
    with 
      | ex -> "syntax_error: " + ex.Message
