# Table of Contents
1. [Antlr4-PowerScript](#antlr4-PowerScript)
2. [Common grammar Points](#common-grammar-points)
	1. [Comments](#comments)
	2. [Identifiers](#identifiers)
3. [Development Points](#development-points)
	1. [Headers](#headers)
	2. [Variable Declaration](#variable-declaration)
		1. [Constants Declaration](#constant-declaration)
		2. [Array Declaration](#array-declaration)
	3. [Forward Declaration](#forward-declaration)
	4. [DataType Declaration](#datatype-declaration)
	5. [Type Variable Declaration](#type-variable-declaration)
	6. [Global Variable Declaration](#global-variable-declaration)
	7. [Function Forward Declaration](#function-forward-declaration)
	8. [Funtions Forward Delcaration](#functions-forward-declaration)
    9. [Function Body Declaration](#function-body-declaration)
    10. [On Body Declaration](#on-body-declaration)
    11. [Event Body Declaration](#event-body-declaration)
	12. [Statements](#statements)
	13. [Expressions](#expressions)

## Antlr4-PowerScript
Creating a grammar for PowerScript in Antlr4.

This project is developed using TDD, so each task is going to be defined by a test which must be passed.

## Common Grammar Points
1. Comments

DONE. TestCommentsBasicRecognition. 
TODO. Review how \n are parser, because there's some cases where they're not being evaluated.

2. Identifiers


## Development Points
Each step belongs to a test that must be passed. The whole grammar is divided in the following points.


 PS10_ForwardDeclaration
 PS11_Forward_DataTypeDeclaration
 PS12_DataType_EventForwardDeclaration
 PS13_TypeVariableDeclarations
 PS14_GlobalVariableDeclarations
 PS15_FunctionForwardDeclaration
 PS16_FunctionsForwardDeclaration

1. Headers

While there seems to be a bug that makes the lexer fail when the token starts with a $, this step is postponed to the future.

```
HA$PBExportHeader$m_mant_desgatra.srm
$PBExportComments$Menu desglose de atrasos.

```

3. Variables

DONE. 
TODO. Transform all capitalized reserved words 

/*	4. Variables

DONE. 00_BooleanLiteral
	DONE. 01_Character_StringLiteral
	DONE. 02_IntegerLiteral
	TODO. 03_FloatPointLiteral

	TODO. Remember to test why tokens are not recognized in composition with = or , As a token is defined in PB there should be 
	splitted in two parsed objects.

	5. Arrays

	DONE. 04_ArrayOfLiteral
*/

4. Forward declaration
```
FORWARD delim
( dataTypeDeclaration | variableDeclaration ) 
END FORWARD delim
```

5. DataTypeDeclaration
```
scopeModifier TYPE id FROM id`id WITHIN id 
(eventForwardDeclaration | descriptorDeclaration | variableDeclaration)
END TYPE
```

```
event_forward_decl_sub
   : 'EVENT' (identifier_name | 'CREATE' | 'DESTROY') identifier_name? (LPAREN parameters_list_sub? RPAREN)? 
   | 'EVENT' 'TYPE' data_type_name identifier_name (LPAREN parameters_list_sub? RPAREN) 
   ;
	
event_forward_decl
   : event_forward_decl_sub delim
   ;
```

6. TypeVariableDeclaration
// TODO: Falta el modificador de acceso 
```
TYPE VARIABLES
(accessModificator | variableDeclaration | constantDeclaration)
END VARIABLES
```

7. GlobalVariableDeclaration
```
( GLOBAL | SHARED ) VARIABLES delim
( variableDeclaration | constantDeclaration )
END VARIABLES delim
```

8. FunctionForwardDeclaration

```
accessModificator? scopeModificator? (FUNTION "dataTypeName" | SUBROUTINE) ID '(' parameterList ')' 
   (LIBRARY "string" (ALIAS FOR "string")? )?
   (RPCFUNC ALIAS FOR "string")?
   (THROWS ID )?
```

9. FunctionsForwardDeclaration
```
(FORWARD | TYPE) PROTOTYPES
   FunctionForwardDeclaration+
END PROTOTYPES
```

10. Function Body

11. Function On_body


