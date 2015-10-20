grammar PowerScript;

compilationUnit
	:	headerDeclaration EOF   #startCompilationUnit
	;

headerDeclaration 
	: headerExport (headerExportComment)*?              #startHeaderDeclaration
	;

headerExport
	:  (EXPORTHEADERBEGIN)*? EXPORTHEADER file  NEW_LINE     #startHeaderExport
	;
headerExportComment
	: EXPORTHEADERCOMMENT comment                  #startHeaderExportComment
	;

file
        : ID '.' ID
        ;
 
comment
        : ID NEW_LINE
        ;

ID          : [a-zA-Z0-9_]+ ;
NEW_LINE    : [ \t\n\r]+ ;
EXPORTHEADERBEGIN   : 'HA';
EXPORTHEADER        : '$PBExportHeader';
EXPORTHEADERCOMMENT : '$PBExportComments';
