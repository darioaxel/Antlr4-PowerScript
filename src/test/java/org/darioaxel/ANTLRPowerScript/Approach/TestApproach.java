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
package org.darioaxel.ANTLRPowerScript.Approach;

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
import org.darioaxel.ANTLRPowerScript.TestErrorListener;
import org.darioaxel.ANTLRPowerScript.basics.CommentsLexer;
import org.junit.Ignore;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
/**
 *
 * @author darioaxel
 */
public class TestApproach {
    
    private static final Logger logger = LoggerFactory.getLogger(TestApproach.class);
    private static final Path test_header = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/Headers/test_header.txt");
    private static final Path test_constants = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/basics/TestConstants.txt");
    private static final Path test_variable = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/basics/TestVariables.txt");
    private static final Path test_variableCharacterStringLiteral = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/basics/TestVariableCharacterStringLiteral.txt");
    private static final Path test_variableIntegerLiteral = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/basics/TestVariableIntegerLiteral.txt");
    private static final Path test_header_one_line = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/Headers/test_header_one_line.txt");
    private static final Path test_headers_forward_with_global_type = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/Headers/test_headers_forward_with_global_type.txt");
   
    @Test
    @Ignore
    public void testPowerScript00Header() throws IOException {

        TestErrorListener errorListener = new TestErrorListener();
        PowerScriptParser.CompilationUnitContext context = parseFile(test_header.toFile(), errorListener);
        assertFalse(errorListener.isFail());    
    }

    @Test
    public void testPS01_Character_StringLiteral() throws IOException {

        TestErrorListener errorListener = new TestErrorListener();
        PS01_Character_StringLiteralParser.CompilationUnitContext context = parseFile01(test_variableCharacterStringLiteral.toFile(), errorListener);
        assertFalse(errorListener.isFail());    
    }
    
    @Test
    public void testPS02_IntegerLiteralParser() throws IOException {

        TestErrorListener errorListener = new TestErrorListener();
        PS02_IntegerLiteralParser.CompilationUnitContext context = parseFile02(test_variableIntegerLiteral.toFile(), errorListener);
        assertFalse(errorListener.isFail());    
    }
    
    private PowerScriptParser.CompilationUnitContext parseFile(File program, 
            TestErrorListener errorListener) throws IOException {
        
        TokenStream inputTokenStream = createInputTokenStream(program);
        PowerScriptParser parser = new PowerScriptParser(inputTokenStream);

        parser.addErrorListener(errorListener);

        PowerScriptParser.CompilationUnitContext context = parser.compilationUnit();
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
    
    private TokenStream createInputTokenStream(File program) throws IOException {
        
        CharStream inputCharStream = new ANTLRInputStream(new FileReader(program));
        TokenSource tokenSource = new CommentsLexer(inputCharStream);
        TokenStream inputTokenStream = new CommonTokenStream(tokenSource);
        
        return inputTokenStream;
    }
}

