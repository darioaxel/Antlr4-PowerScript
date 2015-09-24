package org.darioaxel.ANTLRPowerScript;

import java.io.File;
import java.io.FileReader;
import static org.junit.Assert.*;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.util.BitSet;
import org.antlr.runtime.tree.ParseTree;

import org.antlr.v4.runtime.ANTLRErrorListener;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Parser;
import org.antlr.v4.runtime.RecognitionException;
import org.antlr.v4.runtime.Recognizer;
import org.antlr.v4.runtime.TokenSource;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.atn.ATNConfigSet;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.darioaxel.ANTLRPowerScript.visitor.BasicPowerScriptPBTVisitor;
import org.darioaxel.ANTLRPowerScript.pbt.PowerScriptPBTParser.ProgContext;
import org.darioaxel.ANTLRPowerScript.pbt.PowerScriptPBTParser;
import org.darioaxel.ANTLRPowerScript.pbt.PowerScriptPBTLexer;
import org.darioaxel.ANTLRPowerScript.pbt.PowerScriptPBTListener;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TestPowerScriptPBTRecognition {
	
	private static final Logger logger = LoggerFactory.getLogger(TestPowerScriptPBTRecognition.class);
        private static final Path TestPBT =  FileSystems.getDefault().getPath("../ANTLRPowerScript/src/test/resources/TestPBT.pbt");
	
	@Test
	public void testBasicVisitor() throws IOException{
                                
		TestErrorListener errorListener = new TestErrorListener(); 
		ProgContext context = parseFile(TestPBT.toFile(), errorListener);
		TestPBTVisitor myTestPBTVisitor = new TestPBTVisitor();            
                              
		assertFalse(errorListener.isFail());
			
                boolean allFine;
                allFine = (boolean) myTestPBTVisitor.visit(context);
                
                assertEquals(myTestPBTVisitor.getPBTCompilationNumber(),"19990112");
		
	}
        
        private ProgContext parseFile(File program, TestErrorListener errorListener) throws IOException
	{
		CharStream inputCharStream = new ANTLRInputStream(new FileReader(program));
		TokenSource tokenSource = new PowerScriptPBTLexer(inputCharStream);
		TokenStream inputTokenStream = new CommonTokenStream(tokenSource);
		PowerScriptPBTParser parser = new PowerScriptPBTParser(inputTokenStream);
          
		parser.addErrorListener(errorListener);
		
                ProgContext context = parser.prog();
		return context;
	}
	
	class TestErrorListener implements ANTLRErrorListener {
		
		private boolean fail = false;
		
		public boolean isFail() {
			return fail;
		}

		public void setFail(boolean fail) {
			this.fail = fail;
		}

		@Override
		public void syntaxError(Recognizer<?, ?> arg0, Object arg1, int arg2,
				int arg3, String arg4, RecognitionException arg5) {
			setFail(true);
		}
		
		@Override
		public void reportContextSensitivity(Parser arg0, DFA arg1, int arg2,
				int arg3, int arg4, ATNConfigSet arg5) {
			setFail(true);			
		}
		
		@Override
		public void reportAttemptingFullContext(Parser arg0, DFA arg1, int arg2,
				int arg3, BitSet arg4, ATNConfigSet arg5) {
			setFail(true);
		}
		
		@Override
		public void reportAmbiguity(Parser arg0, DFA arg1, int arg2, int arg3,
				boolean arg4, BitSet arg5, ATNConfigSet arg6) {
			setFail(true);
		}
	}
	
}
