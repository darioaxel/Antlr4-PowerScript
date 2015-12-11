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
import org.darioaxel.ANTLRPowerScript.pbt.PowerScriptPBTParser.ProgContext;
import org.darioaxel.ANTLRPowerScript.pbt.PowerScriptPBTParser;
import org.darioaxel.ANTLRPowerScript.pbt.PowerScriptPBTLexer;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TestPowerScriptPBTRecognition {

    private static final Logger logger = LoggerFactory.getLogger(TestPowerScriptPBTRecognition.class);
    private static final Path TestPBT = FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/basics/TestPBT.pbt");

    @Test
    public void testBasicVisitor() throws IOException {

        TestErrorListener errorListener = new TestErrorListener();
        ProgContext context = parseFile(TestPBT.toFile(), errorListener);

        assertFalse(errorListener.isFail());  
    }

    private ProgContext parseFile(File program, TestErrorListener errorListener) throws IOException {
        CharStream inputCharStream = new ANTLRInputStream(new FileReader(program));
        TokenSource tokenSource = new PowerScriptPBTLexer(inputCharStream);
        TokenStream inputTokenStream = new CommonTokenStream(tokenSource);
        PowerScriptPBTParser parser = new PowerScriptPBTParser(inputTokenStream);

        parser.addErrorListener(errorListener);

        ProgContext context = parser.prog();
        return context;
    }
}
