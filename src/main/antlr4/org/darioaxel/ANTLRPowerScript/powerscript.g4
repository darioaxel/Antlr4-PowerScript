/**
*	Original Author: Darío Ureña
*	E-Mail: darioaxel@gmail.com
*/

grammar powerscript;

compilationUnit
    :  memberDeclaration* EOF
    ;

memberDeclaration
    : forwardDeclaration            
    | fieldDeclaration
    | dataTypeDeclaration
    | typeVariablesDeclaration
    | functionBodyDeclaration
    ;

// Forward declaration

forwardDeclaration
	: forwardDeclarationBegin forwardDeclarationBody* forwardDeclarationEnd	  
	;
	
forwardDeclarationBegin
	: 'forward' delimiter
	;
	
forwardDeclarationEnd
	: 'end' 'forward' delimiter?
	;
	
forwardDeclarationBody
	: fieldDeclaration
	| dataTypeDeclaration
	;

// § Data type declaration	ejemplo: /Ginpix7/Lib/g7xCS_01/n_cst_gestoravisos.sru

dataTypeDeclaration
	: dataTypeDeclarationBegin dataTypeDeclarationBody? dataTypeDeclarationEnd
	;

dataTypeDeclarationBegin
	: scopeModificator? dataTypeDeclarationBeginIdentifier  dataTypeDeclarationParent delimiter
	;

dataTypeDeclarationBeginIdentifier
	: 'type' Identifier 'from'
	;

dataTypeDeclarationParent
	: dataTypeDeclarationParentExpecification? Identifier 
	;

dataTypeDeclarationParentExpecification
	: dataTypeDeclarationParentExpecificationId 'within' 
	;

dataTypeDeclarationParentExpecificationId
	: Identifier '`' Identifier
	| Identifier
	;	

dataTypeDeclarationBody							
	: dataTypeDeclarationDescriptor
	| fieldDeclaration
	| eventForwardDeclaration
	;

dataTypeDeclarationDescriptor
	: 'descriptor' '"' Identifier '"' '=' '"' Identifier '"' delimiter?
	;

dataTypeDeclarationEnd
	: 'end' 'type' delimiter?
	;

scopeModificator
	: 'global'
	| 'local'
	;
	
// EventForwardDeclaration

eventForwardDeclaration
	: 'event' eventForwardTypeDeclaration Identifier? parametersList
	;

eventForwardTypeDeclaration
	: 'type'
	| creatorType
	;
	
creatorType
	: 'create'
	| 'destroy'
	;

parametersList
	: '(' parametersDeclarators? ')'
	;
	
parametersDeclarators 
	: parameterDeclarator (',' parameterDeclarator)*?
	;

parameterDeclarator
	: 'readonly'? 'ref'? primitiveType Identifier
	;
	
// § 3.6 Type Variables Declaration	
typeVariablesDeclaration
	: typeVariablesDeclarationBegin  typeVariablesDeclarationBody typeVariablesDeclarationEnd
	;

typeVariablesDeclarationBody
	: fieldDeclaration
	;
	
typeVariablesDeclarationBegin
	: 'type' 'variables' delimiter?
	;

typeVariablesDeclarationEnd
	: 'end' 'variables' delimiter
	;

// Function Body Declaration

functionBodyDeclaration
	: functionBodyDeclarationHeader functionBodyDeclarationBody* functionBodyDeclarationEnd delimiter
	;
	
functionBodyDeclarationHeader
	: primaryAccessType scopeModificator? functionBodyDeclarationHeaderIdentification parametersList functionBodyDeclarationHeaderEnd? ';'
	;

functionBodyDeclarationHeaderIdentification
	: functionBodyDeclarationHeaderDefinition Identifier
	;

functionBodyDeclarationHeaderDefinition
	: 'function' dataTypeName
	| 'subroutine'
	;

functionBodyDeclarationHeaderEnd
	: 'THROWS' Identifier
	;

functionBodyDeclarationBody
	: statementBlock 
	;

functionBodyDeclarationEnd
	: 'end' 'function'
	| 'end' 'subroutine'
	;
	
statementBlock
    :   fieldDeclaration
    |   statement
    ;

statement
	: expression
	;

// Field Declaration

fieldDeclaration
    :   extendedAccessType? type variableDeclarators delimiter
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
    :   Identifier ('[' ']')*
    ;

qualifiedName
    :   Identifier ('.' Identifier)*
    ;

expression
    :   primary
	|   expression '.' Identifier
	|   expression '(' expressionList? ')'
    |   '(' type ')' expression
    |   expression ('+=' | '-=')
    |   ('+'|'-'|'++'|'--') expression
    |   ('~'|'!') expression
    |   expression ('*'|'/'|'%') expression
    |   expression ('+'|'-') expression
    |   expression ('<' '<' | '>' '>' '>' | '>' '>') expression
    |   expression ('<=' | '>=' | '>' | '<') expression
    |   expression ('==' | '!=') expression
    |   expression '&' expression
    |   expression '^' expression
    |   expression '|' expression
    |   expression 'AND' expression
    |   expression 'OR' expression
    |   expression '?' expression ':' expression
    |   <assoc=right> expression
        (   '='
        |   '+='
        |   '-='
        |   '*='
        |   '/='
        |   '&='
        |   '|='
        |   '^='
        |   '>>='
        |   '>>>='
        |   '<<='
        |   '%='
        )
        expression
    ;
	
expressionList
    :   expression (',' expression)*
    ;

primary
 	:  '(' expression ')'
    |  literal	
	|   Identifier
    ;

literal
    :   IntegerLiteral
    |   BooleanLiteral
    |   'null'
    ;

modifier
    :   'PUBLIC' ':'
    |   'PRIVATE' ':'
    |   'PROTECTED' ':'
    ;

primaryAccessType
	:	'PUBLIC'
	|   'public'
	|   'PRIVATE'
	|   'private'
        |   'PROTECTED'
	|   'protected'
	;

extendedAccessType
    :   'PROTECTEDREAD'
    |   'PRIVATEREAD'
    |   'PROTECTEDWRITE'
    |   'PRIVATEWRITE'
    ;

dataTypeName
    :   'ANY'
    |   'BLOB'
    |   'BOOLEAN'
    |   'BYTE'
    |   'CHARACTER'
    |   'CHAR'
    |   'DATE'
    |   'DATETIME'
    |   'DECIMAL'
    |   'DEC'
    |   'DOUBLE'
    |   'INTEGER'
    |   'INT'
    |   'LONG'
    |   'LONGLONG'
    |   'REAL'
    |   'STRING'
    |   'TIME'
    |   'UNSIGNEDINTEGER'
    |   'UINT'
    |   'UNSIGNEDLONG'
    |   'ULONG'
    |	'WINDOW'
    ;

type
    :   primitiveType ('[' ']')*
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

// §3.10.3 Boolean Literals

BooleanLiteral
    :   'true'
    |   'false'
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
    :   [a-zA-Z0-9$-_%] // these are the "java letters or digits" below 0xFF
    ;

// § COMMENTS & WHITESPACES
COMMENT
    :   '/*' .*? '*/' -> skip
    ;

LINE_COMMENT
    :   '//' ~[\r\n]* -> skip
    ;
	
WS: [ \n\t\r]+ -> skip;