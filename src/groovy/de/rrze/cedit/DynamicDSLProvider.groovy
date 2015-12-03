package de.rrze.cedit

import org.codehaus.groovy.control.CompilationUnit.PrimaryClassNodeOperation
import grails.util.Holders

import grails.plugin.gscripting.GscriptingService
import grails.plugin.gscripting.ScriptRuntimeEnv
import grails.plugin.gscripting.dsl.IContext
import grails.plugin.gscripting.dsl.ast.DefaultAstNodeOperation;

import de.rrze.cedit.CeditDsl

class DynamicDSLProvider implements grails.plugin.gscripting.dsl.IDslResolveStrategyAwareProvider {

	CeditDsl dsl

	def grailsApplication
	def gscriptingService

	DynamicDSLProvider(CeditDsl dsl) {
		this.dsl = dsl

		grailsApplication = Holders.getGrailsApplication()
		gscriptingService = grailsApplication.getMainContext().getBean("gscriptingService")
	}

	@Override
	PrimaryClassNodeOperation getAstNodeOperation() {
		return new DefaultAstNodeOperation()
	}

	@Override
	void addRuntimeConstraints(Object expandoMetaClass) {
//		expandoMetaClass.println = {String msg -> throw new Exception("println is not allowed in this DSL. Please use log instead.")}
	}


	@Override
	String getHandler() {
		return dsl.closureName
	}
	
	@Override
	int getResolveStrategy() {
		return groovy.lang.Closure.DELEGATE_ONLY
	} 

	@Override
	Object getDslInstance(Map scriptParams, IContext ctx, ScriptRuntimeEnv sre){
		return gscriptingService.createScriptRuntimeEnv(dsl.label+"instanciatingScript", dsl.code).run([
			grailsApplication:grailsApplication,
			scriptParams: scriptParams,
			ctx: ctx,
			sre: sre,
			])
	}
}