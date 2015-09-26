/**
*	Original Author: Darío Ureña
*	E-Mail: darioaxel@gmail.com
*/

grammar Comments;

comments
    : ML_COMMENT
    | SL_COMMENT
    | STRING
    | CHAR
    | SPACE
    | OTHER
    ;


ML_COMMENT
    :  '/*' .* '*/'       
    ;

SL_COMMENT
  :  '//' ~('\r' | '\n')*  
  ;

STRING
  :  '"' (STR_ESC | ~('\\' | '"' | '\r' | '\n'))* '"'
  ;

CHAR
  :  '\'' (CH_ESC | ~('\\' | '\'' | '\r' | '\n')) '\''
  ;

SPACE
  :  (' ' | '\t' | '\r' | '\n')+
  ;

OTHER
  :  . // fall-through rule: matches any char if none of the above matched
  ;

fragment STR_ESC
  :  '\\' ('\\' | '"' | 't' | 'n' | 'r') // add more:  Unicode esapes, ...
  ;

fragment CH_ESC
  :  '\\' ('\\' | '\'' | 't' | 'n' | 'r') // add more: Unicode esapes, Octal, ...
  ;