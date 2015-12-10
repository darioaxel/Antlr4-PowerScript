/**
*	Original Author: Darío Ureña
*	E-Mail: darioaxel@gmail.com
*/

grammar PowerScript01Test;

// starting point for parsing a PowerScript file

compilationUnit
    :  typeDeclaration* EOF
    ;

typeDeclaration
    :   modifier* memberDeclaration
    ;

memberDeclaration
    :   constDeclaration
    |   fieldDeclaration
    ;

constDeclaration
    :   'CONSTANT' type constantDeclarator (',' constantDeclarator)* delimiter
    ;

constantDeclarator
    :   Identifier ('[' ']')* '=' variableInitializer
    ;

fieldDeclaration
    :   accessType type variableDeclarators delimiter
    ;

variableDeclarators
    :   variableDeclarator (',' variableDeclarator)*
    ;

variableDeclarator
    :   variableDeclaratorId ('=' variableInitializer)?
    ;

variableInitializer
  //  :   arrayInitializer
  //  |  
    : expression
    ;

variableDeclaratorId
    :   Identifier ('[' ']')*
    ;

expression
    :   primary
    ;

primary
    :   literal
    |   Identifier
    ;

literal
    :   CharacterLiteral
    |   StringLiteral
    |   BooleanLiteral
    |   'null'
    ;

modifier
    :   'PUBLIC' ':'
    |   'PRIVATE' ':'
    |   'PROTECTED' ':'
    ;

accessType
    :   'PROTECTEDREAD'
    |   'PRIVATEREAD'
    |   'PROTECTEDWRITE'
    |   'PRIVATEWRITE'
    ;

type
//    :  classOrInterfaceType ('[' ']')*
    :   primitiveType ('[' ']')*
    ;
/*
classOrInterfaceType
    :   Identifier typeArguments? ('.' Identifier typeArguments? )*
    ;
*/

delimiter
    :   ';'
    |   '\n'
    ;
primitiveType
    :   'boolean'
    |   'char'
    |   'byte'
    |   'short'
    |   'int'
    |   'long'
    |   'float'
    |   'double'
    |   'real'
    ;

// §3.10.3 Boolean Literals

BooleanLiteral
    :   'true'
    |   'false'
    ;

// §3.10.4 Character Literals

CharacterLiteral
    :   '\'' SingleCharacter '\''
    |   '\'' EscapeSequence '\''
    ;

fragment
SingleCharacter
    :   ~['\\]
    ;
// §3.10.5 String Literals
StringLiteral
    :   '"' StringCharacters? '"'
    ;
fragment
StringCharacters
    :   StringCharacter+
    ;
fragment
StringCharacter
    :   ~["\\]
    |   EscapeSequence
    ;

// §3.10.6 Escape Sequences for Character and String Literals

fragment
EscapeSequence
    :   '\\' [btnfr"'\\]
    |   OctalEscape
    |   UnicodeEscape
    ;

fragment
DecimalNumeral
    :   '0'
    |   NonZeroDigit (Digits? | Underscores Digits)
    ;

fragment
Digits
    :   Digit (DigitOrUnderscore* Digit)?
    ;

fragment
Digit
    :   '0'
    |   NonZeroDigit
    ;

fragment
NonZeroDigit
    :   [1-9]
    ;

fragment
OctalEscape
    :   '\\' OctalDigit
    |   '\\' OctalDigit OctalDigit
    |   '\\' ZeroToThree OctalDigit OctalDigit
    ;

fragment
UnicodeEscape
    :   '\\' 'u' HexDigit HexDigit HexDigit HexDigit
    ;

fragment
HexDigits
    :   HexDigit (HexDigitOrUnderscore* HexDigit)?
    ;

fragment
HexDigitOrUnderscore
    :   HexDigit
    |   '_'
    ;

fragment
HexDigit
    :   [0-9a-fA-F]
    ;

fragment
OctalDigits
    :   OctalDigit (OctalDigitOrUnderscore* OctalDigit)?
    ;

fragment
OctalDigit
    :   [0-7]
    ;

fragment
OctalDigitOrUnderscore
    :   OctalDigit
    |   '_'
    ;

fragment
ZeroToThree
    :   [0-3]
    ;

fragment
DigitOrUnderscore
    :   Digit
   |   '_'
    ;

fragment
Underscores
    :   '_'+
    ;

// §3.10.7 NULL

NullLiteral
    :   'null'
    ;

// §3.10.1 Integer Literals

IntegerLiteral
    :   DecimalIntegerLiteral
    ;

fragment
DecimalIntegerLiteral
    :   DecimalNumeral IntegerTypeSuffix?
    ;

fragment
IntegerTypeSuffix
    :   [lL]
    ;

// §3.11 SEPARATORS

LPAREN          : '(';
RPAREN          : ')';
LBRACE          : '{';
RBRACE          : '}';
LBRACK          : '[';
RBRACK          : ']';
SEMI            : ';';
COMMA           : ',';
DOT             : '.';

// §3.12 OPERATORS

ASSIGN          : '=';
GT              : '>';
LT              : '<';
BANG            : '!';
TILDE           : '~';
QUESTION        : '?';
COLON           : ':';
EQUAL           : '==';
LE              : '<=';
GE              : '>=';
NOTEQUAL        : '!=';
AND             : 'AND';
OR              : 'OR';
INC             : '++';
DEC             : '--';
ADD             : '+';
SUB             : '-';
MUL             : '*';
DIV             : '/';
BITAND          : '&';
BITOR           : '|';
CARET           : '^';
MOD             : '%';

ADD_ASSIGN      : '+=';
SUB_ASSIGN      : '-=';
MUL_ASSIGN      : '*=';
DIV_ASSIGN      : '/=';
AND_ASSIGN      : '&=';
OR_ASSIGN       : '|=';
XOR_ASSIGN      : '^=';
MOD_ASSIGN      : '%=';
LSHIFT_ASSIGN   : '<<=';
RSHIFT_ASSIGN   : '>>=';
URSHIFT_ASSIGN  : '>>>=';

// § INDENTIFIERS (must appear after all keywords in the grammar)

Identifier
    :   PBLetter PBLetterOrDigit*
    ;

fragment
PBLetter
    :   [a-zA-Z$-_%] // these are the "java letters" below 0xFF
    |   // covers all characters above 0xFF which are not a surrogate
        ~[\u0000-\u00FF\uD800-\uDBFF]
        {Character.isJavaIdentifierStart(_input.LA(-1))}?
    |   // covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
        [\uD800-\uDBFF] [\uDC00-\uDFFF]
        {Character.isJavaIdentifierStart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)))}?
    ;

fragment
PBLetterOrDigit
    :   [a-zA-Z0-9$-_%] // these are the "java letters or digits" below 0xFF
    |   // covers all characters above 0xFF which are not a surrogate
        ~[\u0000-\u00FF\uD800-\uDBFF]
        {Character.isJavaIdentifierPart(_input.LA(-1))}?
    |   // covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
        [\uD800-\uDBFF] [\uDC00-\uDFFF]
        {Character.isJavaIdentifierPart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)))}?
    ;

// § COMMENTS & WHITESPACES
COMMENT
    :   '/*' .*? '*/' -> skip
    ;

LINE_COMMENT
    :   '//' ~[\r\n]* -> skip
    ;