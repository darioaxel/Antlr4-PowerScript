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

import java.util.ArrayList;
import org.antlr.v4.runtime.tree.ParseTree;
import org.darioaxel.ANTLRPowerScript.pbt.PowerScriptPBTBaseVisitor;
import org.darioaxel.ANTLRPowerScript.pbt.PowerScriptPBTParser;

/**
 *
 * @author darioaxel
 */
public class TestPBTVisitor extends PowerScriptPBTBaseVisitor<Boolean> {
 
    private String pbtCompilationNumber = "";
    public ArrayList<String> paths = new ArrayList<String>();
    private String pbtPath = "";
           
    private void setPBTCompilationNumber(String pbtCNum) {
        this.pbtCompilationNumber = pbtCNum;
    }
    
    public String getPBTCompilationNumber() {
        return this.pbtCompilationNumber;
    }
    @Override
    public Boolean visitProg(PowerScriptPBTParser.ProgContext ctx) {
        for(ParseTree child: ctx.children){
            visit(child);
        }
       
        return true;
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation returns the result of calling
     * {@link #visitChildren} on {@code ctx}.</p>
     */
    @Override
    public Boolean visitHeaders(PowerScriptPBTParser.HeadersContext ctx) {
        this.setPBTCompilationNumber(ctx.NUMBER().getText());
        return  true;
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation returns the result of calling
     * {@link #visitChildren} on {@code ctx}.</p>
     */
    @Override
    public Boolean visitIntolibrarires(PowerScriptPBTParser.IntolibrariresContext ctx) {
        System.out.println(ctx.pathsFromTo(0).getText());        
        return true; 
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation returns the result of calling
     * {@link #visitChildren} on {@code ctx}.</p>
     */
    @Override
    public Boolean visitIntoobjects(PowerScriptPBTParser.IntoobjectsContext ctx) {
        for(PowerScriptPBTParser.PathsFromToContext paths: ctx.pathsFromTo()){
            visit(paths);
        }
        return true;
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation returns the result of calling
     * {@link #visitChildren} on {@code ctx}.</p>
     */
    @Override
    public Boolean visitPathsFromTo(PowerScriptPBTParser.PathsFromToContext ctx) {
        for(PowerScriptPBTParser.PathContext path: ctx.path()) {
            visit(path);
        }
        return true;
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation returns the result of calling
     * {@link #visitChildren} on {@code ctx}.</p>
     */
    @Override
    public Boolean visitPath(PowerScriptPBTParser.PathContext ctx) {
        paths.add(ctx.getText());
        System.out.println("PATH: " + ctx.getText());
        return true;
    }
}
