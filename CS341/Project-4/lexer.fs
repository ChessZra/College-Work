//
// Lexical analyzer for SimpleC programs.  This component 
// translates the input into a list of lexical units or
// "tokens". Each token is a string, so the end result
// is a list of strings.
//
// Returns: a list of strings, for example:
//   ["void";"main";"(";")";"{";"int";"identifier:x",...]
//
// Original author:
//   Prof. Joe Hummel
//   U. of Illinois, Chicago
//   CS 341, Spring 2022
//

namespace compiler

module lexer =
  //
  // NOTE: all types, functions in the module must be indented.
  //
  let private keywords = ["cin"; 
    "cout"; 
    "else"; 
    "endl"; 
    "false";
    "if"; 
    "int"; 
    "main"; 
    "true";
    "void"
  ]

  let private identifier_start = (['a'..'z']@['A'..'Z'])
  let private identifier_chars = (['a'..'z']@['A'..'Z']@['0'..'9'])

  let rec private lookupKeyword id = 
    if (List.contains id keywords) then
      id
    else // not found, so it's an identifier:
      "identifier:" + id

  let private nextChar (input:System.IO.StreamReader) = 
    if input.EndOfStream then
      '$'
    else
      (char (input.Read()))
 
  let rec private skipRestOfLine input = 
    match (nextChar input) with
    | '$'  -> ()
    | '\n' -> ()
    | '\r' -> ()
    |  _   -> skipRestOfLine input

  let rec private collectID nextc input id = 
    if (List.contains nextc identifier_chars) then
      collectID (nextChar input) input (id + (string nextc))
    else 
      (id,nextc)

  let rec private collectStrLiteral nextc input literal = 
    match nextc with
    | '"'  -> literal  // end of string "
    | '\n' -> literal  // end of line:
    | '\r' -> literal
    | '$'  -> literal  // end of file:
    |  _   -> collectStrLiteral (nextChar input) input (literal + (string nextc))

  let rec private collectIntLiteral nextc input literal = 
    if (List.contains nextc ['0'..'9']) then
      collectIntLiteral (nextChar input) input (literal + (string nextc))
    else
      (literal,nextc)

  let rec private lexer nextc input tokens = 
      match nextc with
      | '$' -> List.rev ("$" :: tokens)  // EOF:

      | ' '  -> lexer (nextChar input) input tokens   // whitespace:
      | '\t' -> lexer (nextChar input) input tokens
      | '\n' -> lexer (nextChar input) input tokens
      | '\r' -> lexer (nextChar input) input tokens

      | ';' -> lexer (nextChar input) input (";" :: tokens)
      | '(' -> lexer (nextChar input) input ("(" :: tokens)
      | ')' -> lexer (nextChar input) input (")" :: tokens)
      | '{' -> lexer (nextChar input) input ("{" :: tokens)
      | '}' -> lexer (nextChar input) input ("}" :: tokens)
      | '^' -> lexer (nextChar input) input ("^" :: tokens)
      | '+' -> lexer (nextChar input) input ("+" :: tokens)
      | '-' -> lexer (nextChar input) input ("-" :: tokens)
      | '*' -> lexer (nextChar input) input ("*" :: tokens)
      | '/' -> // could be division, or a comment:
               let lookahead = (nextChar input)
               if lookahead = '/' then
                 skipRestOfLine input
                 lexer (nextChar input) input tokens
               else
                 lexer lookahead input ("/" :: tokens)
      | '=' -> // could be =, or ==
               let lookahead = (nextChar input)
               if lookahead = '=' then
                 lexer (nextChar input) input ("==" :: tokens)
               else
                 lexer lookahead input ("=" :: tokens)
      | '<' -> // could be <, <=, or <<
               let lookahead = (nextChar input)
               if lookahead = '=' then
                 lexer (nextChar input) input ("<=" :: tokens)
               else if lookahead = '<' then
                 lexer (nextChar input) input ("<<" :: tokens)
               else
                 lexer lookahead input ("<" :: tokens)
      | '>' -> // could be >, >=, or >>
               let lookahead = (nextChar input)
               if lookahead = '=' then
                 lexer (nextChar input) input (">=" :: tokens)
               else if lookahead = '>' then
                 lexer (nextChar input) input (">>" :: tokens)
               else
                 lexer lookahead input (">" :: tokens)
      | '!' -> // could be !, or !=
               let lookahead = (nextChar input)
               if lookahead = '=' then
                 lexer (nextChar input) input ("!=" :: tokens)
               else
                 lexer lookahead input ("!" :: tokens)
      | '&' -> // expecting &&
               let lookahead = (nextChar input)
               if lookahead = '&' then
                 lexer (nextChar input) input ("&&" :: tokens)
               else
                 lexer lookahead input ("unknown:&" :: tokens)
      | '|' -> // expecting ||
               let lookahead = (nextChar input)
               if lookahead = '|' then
                 lexer (nextChar input) input ("||" :: tokens)
               else
                 lexer lookahead input ("unknown:|" :: tokens)
     
      | '"' -> let literal = collectStrLiteral (nextChar input) input ""  // "
               lexer (nextChar input) input (("str_literal:" + literal) :: tokens)

      |  _  when List.contains nextc identifier_start ->
               // collect letters and numbers into identifier, either keyword or identifier:
               let (id,lookahead) = collectID (nextChar input) input (string nextc)
               let token = lookupKeyword id  // could be keyword or identifier
               lexer lookahead input (token :: tokens)

      |  _  when List.contains nextc ['0'..'9'] ->
               // collect digits into an integer literal:
               let (literal,lookahead) = collectIntLiteral (nextChar input) input (string nextc)
               lexer lookahead input (("int_literal:" + literal) :: tokens)

      |  _  -> lexer (nextChar input) input (("unknown:" + (string nextc)) :: tokens)
 

  //
  // analyzer filename
  //
  // Given a filename representing a SimpleC program, returns
  // a list of tokens, where each token is a sub-list.
  //
  let analyze (filename:string) = 
    use input = new System.IO.StreamReader(filename)
    lexer (nextChar input) input []
