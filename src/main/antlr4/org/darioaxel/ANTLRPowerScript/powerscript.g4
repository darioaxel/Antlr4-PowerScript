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
    | typeDeclaration
    | localVariableDeclarationBlock
    | globalVariableDeclarationBlock
    | variableDeclaration
    | constantDeclaration
   // | functionDeclaration
   // | functionDeclarationBlock
    | functionImplementation
   // | onBodyImplementation
    | eventDeclaration
   // | eventImplementation
    ;

// 1. Forward Declaration

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
	: variableDeclaration
	| typeDeclaration
	;

// 2. Type Declaration	ejemplo: /Ginpix7/Lib/g7xCS_01/n_cst_gestoravisos.sru
typeDeclaration
	: typeDeclarationBegin typeDeclarationBody? typeDeclarationEnd
	;

typeDeclarationBegin
	: scopeModificator? typeDeclarationBeginIdentifier  typeDeclarationParent delimiter
	;

typeDeclarationBeginIdentifier
	: 'type' Identifier 'from'
	;

typeDeclarationParent
	: typeDeclarationParentExpecification? Identifier 
	;

typeDeclarationParentExpecification
	: typeDeclarationParentExpecificationId 'within' 
	;

typeDeclarationParentExpecificationId
	: Identifier '`' Identifier
	| Identifier
	;	

typeDeclarationBody							
	: typeDeclarationDescriptor
	| variableDeclaration
	| eventDeclaration
	;

typeDeclarationDescriptor
	: 'descriptor' '"' Identifier '"' '=' '"' Identifier '"' delimiter?
	;

typeDeclarationEnd
	: 'end' 'type' delimiter?
	;

// 3. Local Variable Declaration Block
localVariableDeclarationBlock
	: localVariableDeclarationBegin  localVariableDeclarationBody localVariableDeclarationEnd
	;

localVariableDeclarationBody
	: variableDeclaration
	;
	
localVariableDeclarationBegin
	: 'type' 'variables' delimiter?
	;

localVariableDeclarationEnd
	: 'end' 'variables' delimiter
	;

// 4. Global Variable Declaration Block
globalVariableDeclarationBlock
    : globalVariableDeclarationBlockBegin globalVariableDeclarationBlockBody globalVariableDeclarationBlockEnd
    ;

globalVariableDeclarationBlockBegin
    : globalScopeModificator 'variables' delimiter
    ;

globalVariableDeclarationBlockBody
    : variableDeclaration
    | constantDeclaration
    ;

globalVariableDeclarationBlockEnd
    : 'end' 'variables' delimiter?
    ;

// 5. Variable Declaration
variableDeclaration
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

// 6. Constants Declaration

constantDeclaration
    :   'constant' type constantDeclarator (',' constantDeclarator)* delimiter
    ;

constantDeclarator
    :   Identifier arrayLengthDeclarator* '=' variableInitializer
    ;

// 9. Function Implementation
functionImplementation
	: functionImplementationHeader functionImplementationBody* functionImplementationEnd delimiter
	;
	
functionImplementationHeader
	: primaryAccessType scopeModificator? functionImplementationHeaderIdentification parametersList functionImplementationHeaderEnd? ';'
	;

functionImplementationHeaderIdentification
	: functionImplementationHeaderDefinition Identifier
	;

functionImplementationHeaderDefinition
	: 'function' dataTypeName
	| 'subroutine'
	;

functionImplementationHeaderEnd
	: 'THROWS' Identifier
	;

functionImplementationBody
	: statementBlock 
	;

functionImplementationEnd
	: 'end' 'function'
	| 'end' 'subroutine'
	;

// 11. Event Declaration
eventDeclaration
	: 'event' eventTypeDeclaration Identifier? parametersList
	;

eventTypeDeclaration
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

scopeModificator
	: 'global'
	| 'local'
	;

globalScopeModificator
        : 'global'
        | 'shared'
        ;
	
statementBlock
    :   variableDeclaration
    |   statement
    ;

statement
	: expression
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
	:   'PUBLIC'
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