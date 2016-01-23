# Table of Contents
1. [Antlr4-PowerScript](#antlr4-PowerScript)
2. [Development Points](#development-points)
	1. [Comments](#comments)
	2. [Headers](#headers)
	3. [Variable Declaration](#variable-declaration)
		1. [Constants Declaration](#constant-declaration)
		2. [Array Declaration](#array-declaration)
	4. [Forward Declaration](#forward-declaration)
	5. [DataType Declaration](#datatype-declaration)
	6. [Type Variable Declaration](#type-variable-declaration)
	7. [Global Variable Declaration](#global-variable-declaration)
	8. [Function Forward Declaration](#function-forward-declaration)
	9. [Funtions Forward Delcaration](#functions-forward-declaration)
    10. [Function Body Declaration](#function-body-declaration)
    12. [On Body Declaration](#on-body-declaration)
    13. [Event Body Declaration](#event-body-declaration)
	14. [Statements](#statements)
	15. [Expressions](#expressions)

## Antlr4-PowerScript
Creating a grammar for PowerScript in Antlr4.

This project is developed using TDD, so each task is going to be defined by a test which must be passed.

## Development Points
Each step belongs to a test that must be passed. The whole grammar is divided in the following points.

1. Comments

DONE. TestCommentsBasicRecognition. 
TODO. Review how \n are parser, because there's some cases where they're not being evaluated.

2. Headers

While there seems to be a bug that makes the lexer fail when the token starts with a $, this step is postponed to the future.

```
HA$PBExportHeader$m_mant_desgatra.srm
$PBExportComments$Menu desglose de atrasos.

```

3. Variables

DONE. 
TODO. Transform all capitalized reserved words 

	4. Variables

	DONE. 00_BooleanLiteral
	DONE. 01_Character_StringLiteral
	DONE. 02_IntegerLiteral
	TODO. 03_FloatPointLiteral

	TODO. Remember to test why tokens are not recognized in composition with = or , As a token is defined in PB there should be 
	splitted in two parsed objects.

	5. Arrays

	DONE. 04_ArrayOfLiteral

4. Forward declaration

FORWARD delim
( dataTypeDeclaration | variableDeclaration ) 
END FORWARD delim

5. DataTypeDeclaration

scopeModifier TYPE id FROM id`id WITHIN id 
(eventForwardDeclaration | descriptorDeclaration | variableDeclaration)
END TYPE

6. TypeVariableDeclaration

TYPE VARIABLES
(variableDeclaration | constantDeclaration)
END VARIABLES

7. GlobalVariableDeclaration

( GLOBAL | SHARED ) VARIABLES delim
( variableDeclaration | constantDeclaration )
END VARIABLES delim

8. FunctionForwardDeclaration

descriptor "comment" = "Entidad"

9. FunctionsForwardDeclaration

10. Function Body

11. Function On_body


