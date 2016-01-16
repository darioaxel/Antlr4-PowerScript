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
import org.darioaxel.ANTLRPowerScript.basics.CommentsLexer;
import org.darioaxel.ANTLRPowerScript.basics.PSbasics_HeaderParser;
import org.junit.Test;

/**
 *
 * @author darioaxel
 */
public class TestBasics {
    
    private static final Path test_PSbasics_Header = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/Headers/test_header.txt");
  
    @Test
    public void testPSbasics_Header() throws IOException {

        TestErrorListener errorListener = new TestErrorListener();
        PSbasics_HeaderParser.CompilationUnitContext context1 = parseFile_basics_Header(test_PSbasics_Header.toFile(), errorListener);
        assertFalse(errorListener.isFail());    
    }
    
    private PSbasics_HeaderParser.CompilationUnitContext parseFile_basics_Header(File program, 
            TestErrorListener errorListener) throws IOException {
        
        TokenStream inputTokenStream = createInputTokenStream(program);
        PSbasics_HeaderParser parser = new PSbasics_HeaderParser(inputTokenStream);

        parser.addErrorListener(errorListener);

        PSbasics_HeaderParser.CompilationUnitContext context = parser.compilationUnit();
        return context;
    }
 
    
    private TokenStream createInputTokenStream(File program) throws IOException {
        
        CharStream inputCharStream = new ANTLRInputStream(new FileReader(program));
        TokenSource tokenSource = new CommentsLexer(inputCharStream);
        TokenStream inputTokenStream = new CommonTokenStream(tokenSource);
        
        return inputTokenStream;
    }
}


