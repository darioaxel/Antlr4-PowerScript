/**
*	Original Author: Darío Ureña
*	E-Mail: darioaxel@gmail.com
*/

grammar PS04_ArrayOfLiteral;

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
    :   'constant' type constantDeclarator (',' constantDeclarator)* delimiter
    ;

constantDeclarator
    :   Identifier arrayLengthDeclarator* '=' variableInitializer
    ;

fieldDeclaration
    :   accessType? type variableDeclarators delimiter
    ;

variableDeclarators
    :   variableDeclarator (',' variableDeclarator)*
    ;

variableDeclarator
    :   variableDeclaratorId ('=' variableInitializer)?
    ;

variableInitializer 
    : expression
    ;

variableDeclaratorId
    :   Identifier arrayLengthDeclarator*
    ;

expression
    :   primary
    ;

primary
    :   literal
    ;

literal
    :   IntegerLiteral
    |	StringLiteral
    |   CharacterLiteral
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
    :   primitiveType arrayLengthDeclarator*
    ;

arrayLengthDeclarator
	: '[' arrayLengthValue* ']'
	;

arrayLengthValue
	: arrayLengthRange (',' arrayLengthRange)*
	;

arrayLengthRange
	:  IntegerLiteral ('TO' IntegerLiteral)*
	;

delimiter
    :   ';'
    |   '\n'
    ;

primitiveType
    :   'boolean'
    |   'char'
    |   'byte'
    |   'short'
    |   'integer'
    |   'long'
    |   'float'
    |   'double'
    |   'real'
    |	'string'
    |	'integer'
    ;

// §3.10.1 Boolean Literals

BooleanLiteral
    :   'true'
    |   'false'
    ;

// §3.10.2 Integer Literals

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

// §3.10.3 Character Literals

CharacterLiteral
    :   '\'' SingleCharacter '\''
    |   '\'' EscapeSequence '\''
    ;

fragment
SingleCharacter
    :   ~['\\]
    ;
	
// §3.10.4 String Literals

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

// §3.10.5 Escape Sequences for Character and String Literals

fragment
EscapeSequence
    :   '\\' [btnfr"'\\]
    |   OctalEscape
    |   UnicodeEscape
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

// §3.10.6 NULL

NullLiteral
    :   'null'
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
    :   [a-zA-Z$-_%] 
    ;

fragment
PBLetterOrDigit
    :   [a-zA-Z0-9$-_%] 
    ;

// § COMMENTS & WHITESPACES
COMMENT
    :   '/*' .*? '*/' -> skip
    ;

LINE_COMMENT
    :   '//' ~[\r\n]* -> skip
    ;
	
WS: [ \n\t\r]+ -> skip;