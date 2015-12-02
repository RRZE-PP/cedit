package de.rrze.cedit

import org.codehaus.groovy.control.CompilationUnit.PrimaryClassNodeOperation
import grails.util.Holders

import grails.plugin.gscripting.GscriptingService
import grails.plugin.gscripting.ScriptRuntimeEnv
import grails.plugin.gscripting.dsl.IContext

import de.rrze.cedit.ScriptInterpretingDSL

class DynamicDSLProvider implements grails.plugin.gscripting.dsl.IDslProvider {

	ScriptInterpretingDSL dsl

	def grailsApplication
	def gscriptingService

	DynamicDSLProvider(ScriptInterpretingDSL dsl){
		this.dsl = dsl

		grailsApplication = Holders.getGrailsApplication()
		gscriptingService = grailsApplication.getMainContext().getBean("gscriptingService")
	}

	@Override
	PrimaryClassNodeOperation getAstNodeOperation(){
		return new ASTNodeOperation()
	}

	@Override
	void addRuntimeConstraints(expandoMetaClass){}


	@Override
	String getHandler(){
		return dsl.closureName
	}

	@Override
	Object getDslInstance(Map scriptParams, IContext context, ScriptRuntimeEnv sre){
		return gscriptingService.createScriptRuntimeEnv(dsl.label+"instanciatingScript", dsl.code).run(context.callParams)
	}
}

import org.codehaus.groovy.ast.ClassNode;
import org.codehaus.groovy.classgen.GeneratorContext;
import org.codehaus.groovy.control.SourceUnit;

/**
 * @author unrz157
 *
 */
 //fixme: dafuq? brauchen wir das?
class ASTNodeOperation extends PrimaryClassNodeOperation {
	public void call(SourceUnit source, GeneratorContext context, ClassNode classNode) {
		source.getAST().
		getStatementBlock().
		visit(new ConstraintVisitor())
	}
}


import org.codehaus.groovy.ast.CodeVisitorSupport
import org.codehaus.groovy.ast.expr.ConstantExpression
import org.codehaus.groovy.ast.expr.MethodCallExpression

/**
 * @author unrz157
 *
 */
class ConstraintVisitor extends CodeVisitorSupport {
	def constraintVerbs =['exit']

	void visitMethodCallExpression(MethodCallExpression expression) {

		ConstantExpression method = expression.getMethod()

		if(constraintVerbs.contains(method.getValue())){
			throw new Exception("SE DSL: ${method.getValue()} is not allowed");
		}

		super.visitMethodCallExpression(expression)
	}
}
