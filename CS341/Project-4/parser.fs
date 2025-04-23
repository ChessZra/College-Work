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
// <<YOUR NAME>>
//
// Original author:
//   Prof. Joe Hummel
//   U. of Illinois, Chicago
//   CS 341, Spring 2022
//

namespace compiler

module parser =
  //
  // NOTE: all functions in the module must be indented.
  //

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

    if expected_token = next_token then  
      List.tail tokens
    else
      failwith ("expecting " + expected_token + ", but found " + next_token)

  let beginswith (pattern: string) (literal: string) =
    literal.StartsWith pattern

  let expr_value tokens = 
    let next_token = List.head tokens

    if beginswith "str_literal:" next_token then 
      matchToken "str_literal:" tokens
    else if beginswith "int_literal:" next_token then
      matchToken "int_literal:" tokens
    else if next_token = "false" then
      matchToken "false" tokens
    else if next_token = "true" then
      matchToken "true" tokens
    else if next_token = "identifier:" then
      matchToken "identifier:" tokens
    else 
      failwith ("expecting literal, but found " + next_token)

  let private output_value tokens = 
    let next_token = List.head tokens
    if next_token = "endl" then
      matchToken "endl" tokens
    else
      expr_value tokens

  let private output tokens = 
    let T1 = matchToken "cout" tokens
    let T2 = matchToken "<<" T1
    let T3 = output_value T2
    matchToken ";" T3

  let private empty tokens = 
    matchToken ";" tokens

  let private vardec1 tokens = 
    matchToken "int" tokens
    
  
  let rec private stmt tokens = 
    let next_token = List.head tokens
    if next_token = ";" then
      empty tokens
    else if next_token = "int" then 
      vardec1 tokens
    else if next_token = "cin" then
      input tokens
    else if next_token = "cout" then
      output tokens
    else if beginswith "identifier:" next_token
      assignment tokens 
    else if next_token = "if" then 
      ifstmt tokens
    else
      failwith ("expecting statement, but found " + next_token) 

  let rec private morestmts tokens = 
    let next_token = List.head tokens
    if next_token = "}" then // This is a bit ambiguous...
      tokens
    else 
      let T1 = stmt tokens
      morestmts T1

  let private stmts tokens = 
    let T1 = stmt tokens
    morestmts T1

  //
  // simpleC
  //
  let private simpleC tokens = 

    let T1 = matchToken "void" tokens
    let T2 = matchToken "main" T1
    let T3 = matchToken "(" T2
    let T4 = matchToken ")" T3
    let T5 = matchToken "{" T4
    let T6 = stmts T5
    let T7 = matchToken "}" T6
    let T8 = matchToken "$" T7
    T8


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
