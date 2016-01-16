/*
 * The MIT License
 *
 * Copyright 2015 darioaxel.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package org.darioaxel.ANTLRPowerScript;

import java.io.File;
import java.io.FileReader;
import static org.junit.Assert.*;

import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.TokenSource;
import org.antlr.v4.runtime.TokenStream;
import org.darioaxel.ANTLRPowerScript.Approach.PS01_Character_StringLiteralParser;
import org.darioaxel.ANTLRPowerScript.Approach.PS02_IntegerLiteralParser;
import org.darioaxel.ANTLRPowerScript.Approach.PS03_AllLiteralsParser;
import org.darioaxel.ANTLRPowerScript.Approach.PS04_ArrayOfLiteralParser;
import org.darioaxel.ANTLRPowerScript.Approach.PS00_FirstApproachParser;
import org.darioaxel.ANTLRPowerScript.basics.CommentsLexer;
import org.junit.Ignore;
import org.junit.Test;
/**
 *
 * @author darioaxel
 */
public class TestLiteral {
    
    private static final Path test_header = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/Headers/test_header.txt");
    private static final Path test_variableCharacterStringLiteral = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/Literals/TestVariableCharacterStringLiteral.txt");
    private static final Path test_variableIntegerLiteral = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/Literals/TestVariableIntegerLiteral.txt");
    private static final Path test_allLiterals = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/Literals/TestAllLiterals.txt");
    private static final Path test_arrayOfLiterals = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/Literals/TestArrayOfLiterals.txt");
   
    @Test
    @Ignore
    public void testPowerScript00Header() throws IOException {

        TestErrorListener errorListener = new TestErrorListener();
        PS00_FirstApproachParser.CompilationUnitContext context0 = parseFile(test_header.toFile(), errorListener);
        assertFalse(errorListener.isFail());    
    }

    @Test
    public void testPS01_Character_StringLiteral() throws IOException {

        TestErrorListener errorListener = new TestErrorListener();
        PS01_Character_StringLiteralParser.CompilationUnitContext context1 = parseFile01(test_variableCharacterStringLiteral.toFile(), errorListener);
        assertFalse(errorListener.isFail());    
    }
    
    @Test
     @Ignore
    public void testPS02_IntegerLiteralParser() throws IOException {

        TestErrorListener errorListener = new TestErrorListener();
        PS02_IntegerLiteralParser.CompilationUnitContext context2 = parseFile02(test_variableIntegerLiteral.toFile(), errorListener);
        assertFalse(errorListener.isFail());    
    }
    
    @Test
     @Ignore
    public void testPS03_AllLiteralsParser() throws IOException {

        TestErrorListener errorListener = new TestErrorListener();
        PS03_AllLiteralsParser.CompilationUnitContext context3 = parseFile03(test_allLiterals.toFile(), errorListener);
        assertFalse(errorListener.isFail());    
    }
    
    @Test
    @Ignore
    public void PS04_ArrayOfLiteralParser() throws IOException {

        TestErrorListener errorListener = new TestErrorListener();
        PS04_ArrayOfLiteralParser.CompilationUnitContext context4 = parseFile04(test_arrayOfLiterals.toFile(), errorListener);
        assertFalse(errorListener.isFail());    
    }
    
    private PS00_FirstApproachParser.CompilationUnitContext parseFile(File program, 
            TestErrorListener errorListener) throws IOException {
        
        TokenStream inputTokenStream = createInputTokenStream(program);
        PS00_FirstApproachParser parser = new PS00_FirstApproachParser(inputTokenStream);

        parser.addErrorListener(errorListener);

        PS00_FirstApproachParser.CompilationUnitContext context = parser.compilationUnit();
        return context;
    }
    
    private PS01_Character_StringLiteralParser.CompilationUnitContext parseFile01(File program, 
            TestErrorListener errorListener) throws IOException {
        
        TokenStream inputTokenStream = createInputTokenStream(program);
        PS01_Character_StringLiteralParser parser = new PS01_Character_StringLiteralParser(inputTokenStream);

        parser.addErrorListener(errorListener);

        PS01_Character_StringLiteralParser.CompilationUnitContext context = parser.compilationUnit();
        return context;
    }
    
    private PS02_IntegerLiteralParser.CompilationUnitContext parseFile02(File program, 
            TestErrorListener errorListener) throws IOException {
        
        TokenStream inputTokenStream = createInputTokenStream(program);
        PS02_IntegerLiteralParser parser = new PS02_IntegerLiteralParser(inputTokenStream);

        parser.addErrorListener(errorListener);

        PS02_IntegerLiteralParser.CompilationUnitContext context = parser.compilationUnit();
        return context;
    }
    
    private PS03_AllLiteralsParser.CompilationUnitContext parseFile03(File program, 
            TestErrorListener errorListener) throws IOException {
        
        TokenStream inputTokenStream = createInputTokenStream(program);
        PS03_AllLiteralsParser parser = new PS03_AllLiteralsParser(inputTokenStream);

        parser.addErrorListener(errorListener);

        PS03_AllLiteralsParser.CompilationUnitContext context = parser.compilationUnit();
        return context;
    }
    
     private PS04_ArrayOfLiteralParser.CompilationUnitContext parseFile04(File program, 
            TestErrorListener errorListener) throws IOException {
        
        TokenStream inputTokenStream = createInputTokenStream(program);
        PS04_ArrayOfLiteralParser parser = new PS04_ArrayOfLiteralParser(inputTokenStream);

        parser.addErrorListener(errorListener);

        PS04_ArrayOfLiteralParser.CompilationUnitContext context = parser.compilationUnit();
        return context;
    }
    
    
    private TokenStream createInputTokenStream(File program) throws IOException {
        
        CharStream inputCharStream = new ANTLRInputStream(new FileReader(program));
        TokenSource tokenSource = new CommentsLexer(inputCharStream);
        TokenStream inputTokenStream = new CommonTokenStream(tokenSource);
        
        return inputTokenStream;
    }
}

