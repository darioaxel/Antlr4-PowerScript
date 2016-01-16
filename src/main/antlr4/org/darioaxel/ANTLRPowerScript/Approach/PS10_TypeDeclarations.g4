/**
*	Original Author: Darío Ureña
*	E-Mail: darioaxel@gmail.com
*/

grammar PS10_TypeDeclarations;

compilationUnit
    :  memberDeclaration* EOF
    ;

memberDeclaration
	: forwardDeclaration
	| typeDeclaration
	| typeVariablesDeclaration
	;

// § forward
forwardDeclaration
	: forwardDeclarationBegin forwardDeclarationBody* forwardDeclarationEnd	  
	;
	
forwardDeclarationBegin
	: 'forward' delimiter
	;
	
forwardDeclarationEnd
	: 'end' 'forward' delimiter
	;
	
forwardDeclarationBody
	: typeDeclaration
	| variableDeclarations
	;

// § type
typeDeclaration
	: typeDeclarationBegin typeDeclarationBody? typeDeclarationEnd
	;

typeDeclarationBegin
	: scopeModificator? typeDeclarationBeginIdentifier  typeDeclarationParent
	;

typeDeclarationBeginIdentifier
	: 'type' ID 'from'
	;

typeDeclarationParent
	: typeDeclarationParentExpecification? ID delimiter?
	;

typeDeclarationParentExpecification
	: typeDeclarationParentExpecificationId 'within' 
	;

typeDeclarationParentExpecificationId
	: ID '`' ID
	| ID
	;	

typeDeclarationBody
	: typeDeclarationDescriptor
	;

typeDeclarationDescriptor
	: 'descriptor' '"' ID '"' '=' '"' ID '"' delimiter?
	;

typeDeclarationEnd
	: 'end' 'type' delimiter?
	;
	
// § variables	
typeVariablesDeclaration
	: typeVariablesDeclarationBegin  EXPRESSION typeVariablesDeclarationEnd
	;
	
typeVariablesDeclarationBegin
	: 'type' 'variables' delimiter?
	;

typeVariablesDeclarationEnd
	: 'end' 'variables' delimiter
	;

delimiter
    :   ';'
    |   '\n'
    ;

variableDeclarations
	: ID variableList
	;
	
variableList
	: ',' variableDeclarations
	;

EXPRESSION : 'expression' ;
ID : 'id';

scopeModificator
	: 'global'
	| 'local'
	;

// § COMMENTS & WHITESPACES
COMMENT
    :   '/*' .*? '*/' -> skip
    ;

LINE_COMMENT
    :   '//' ~[\r\n]* -> skip
    ;
	
WS: [ \n\t\r]+ -> skip;

