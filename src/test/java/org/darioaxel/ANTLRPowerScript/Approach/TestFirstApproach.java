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
import org.darioaxel.ANTLRPowerScript.basics.CommentsParser;
import org.darioaxel.ANTLRPowerScript.basics.TestBasicsCommentsVisitor;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
/**
 *
 * @author darioaxel
 */
public class TestFirstApproach {
    
    private static final Logger logger = LoggerFactory.getLogger(TestFirstApproach.class);
    private static final Path TestPBT = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/basics/TestComments.txt");

    @Test
    public void testFirsApproachVisitor() throws IOException {

        TestErrorListener errorListener = new TestErrorListener();
        CommentsParser.CommentsContext context = parseFile(TestPBT.toFile(), errorListener);
        TestBasicsCommentsVisitor myTestBasicsCommentsVisitor = new TestBasicsCommentsVisitor();

        assertFalse(errorListener.isFail());

        String allFine;      
        allFine = (String) myTestBasicsCommentsVisitor.visitComments(context);
    }

    private CommentsParser.CommentsContext parseFile(File program, TestErrorListener errorListener) throws IOException {
        
        CharStream inputCharStream = new ANTLRInputStream(new FileReader(program));
        TokenSource tokenSource = new CommentsLexer(inputCharStream);
        TokenStream inputTokenStream = new CommonTokenStream(tokenSource);
        CommentsParser parser = new CommentsParser(inputTokenStream);

        parser.addErrorListener(errorListener);

        CommentsParser.CommentsContext context = parser.comments();
        return context;
    }
}

