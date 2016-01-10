# Antlr4-PowerScript
Creating a grammar for PowerScript in Antlr4.

This project is developed using TDD, so each task is going to be defined by a test which must be passed.

## Development Steps
Each step belongs to a test that must be passed. The whole grammar is divided in the following points.

1. Comments
DONE. TestCommentsBasicRecognition. 
TODO. Review how \n are parser, because there's some cases where they're not being evaluated.

2. Headers

While there seems to be a bug that makes the lexer fail when the token starts with a $, this step is postponed to the future.

3. Constants

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

6. Expressions

7. Type variables

8. Forward declaration

9. Global variables

10. Function_Subroutine declaration

11. Function Prototype declaration

12. Function Body

13. Function On_body

14. Event Declaration



4. TODO
