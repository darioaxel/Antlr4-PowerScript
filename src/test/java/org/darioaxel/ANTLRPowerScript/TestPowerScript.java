/*
 * The MIT License
 *
 * Copyright 2016 darioaxel.
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
import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.TokenSource;
import org.antlr.v4.runtime.TokenStream;
import static org.junit.Assert.assertFalse;
import org.junit.Test;

/**
 *
 * @author darioaxel
 */
public class TestPowerScript {
     
    private static final Path test_powerscript01 = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/Powerscript/powerscript01.sru");
    
    @Test
    public void testPowerscript01() throws IOException {

        TestErrorListener errorListener = new TestErrorListener();
        powerscriptParser.CompilationUnitContext context01 = parsePowerscript01(test_powerscript01.toFile(), errorListener);
        assertFalse(errorListener.isFail());    
    }
    
    private powerscriptParser.CompilationUnitContext parsePowerscript01(File program, 
            TestErrorListener errorListener) throws IOException {
        
        TokenStream inputTokenStream = createInputTokenStream(program);
        powerscriptParser parser = new powerscriptParser(inputTokenStream);

        parser.addErrorListener(errorListener);

        powerscriptParser.CompilationUnitContext context = parser.compilationUnit();
        return context;
    }
    
      private TokenStream createInputTokenStream(File program) throws IOException {
        
        CharStream inputCharStream = new ANTLRInputStream(new FileReader(program));
        TokenSource tokenSource = new powerscriptLexer(inputCharStream);
        TokenStream inputTokenStream = new CommonTokenStream(tokenSource);
        
        return inputTokenStream;
    }
}
