import de.rrze.cedit.CeditTemplate;
import de.rrze.cedit.CeditScript
import de.rrze.cedit.CeditDsl

class CeditBootStrap {

	def init = { servletContext ->

		// init default cedit dsl
		def defaultDsl = CeditDsl.findByLabel('DefaultDsl')?:new CeditDsl([label:'DefaultDsl', closureName: 'cedit', code:'''
import org.apache.commons.logging.LogFactory

import grails.plugin.gscripting.ScriptRuntimeEnv;
import grails.plugin.gscripting.dsl.IContext;
import grails.plugin.gscripting.dsl.impl.DefaultContext;

class DefaultDsl implements GroovyInterceptable {

	def grailsApplication
	
	Map scriptParams
	IContext ctx
	ScriptRuntimeEnv sre
	
	def log

	def app = [:]
	
	public DefaultDsl(def grailsApplication, Map scriptParams, IContext ctx, ScriptRuntimeEnv sre) {
		this.grailsApplication = grailsApplication
		this.scriptParams = scriptParams
		this.ctx = ctx
		this.sre = sre
		this.log = LogFactory.getLog("grails.plugin.gscripting.script.${ctx.metadata.qualifiedName}".toString());
		grailsApplication.serviceClasses.each {
			def bean = grailsApplication.mainContext.getBean(it.propertyName)
			this.app.put(it.propertyName, grailsApplication.mainContext.getBean(it.propertyName))
		}
	}
	
	@Override
	public Object invokeMethod(String name, Object args) {
//		log.trace "Calling ${name} with ${args} ..."
		def ret
//		def startTime = System.currentTimeMillis()
		def calledMethod = DefaultDsl.metaClass.getMetaMethod(name, args)
		if(!calledMethod) {
			throw new MissingMethodException(name, this.getClass(), args)
		}
		ret = calledMethod?.invoke(this, args)
//		def endTime = System.currentTimeMillis()
//		log.trace "Calling ${name} took ${endTime-startTime}ms"
		return ret
	}
	
	@Override
	public Object getProperty(String name) {
//		this.log.trace "Getting ${name} ..."
		if(name in DefaultDsl.metaClass.properties.name)
			return  DefaultDsl.metaClass.getProperty(this, name)
		if(name in DefaultContext.metaClass.properties.name)
			return DefaultContext.metaClass.getProperty(ctx, name)
		if(ctx.state.containsKey(name))
			return ctx.state[name]
		throw new MissingPropertyException(name, this.getClass());
	}
	
	@Override
	public void setProperty(String name, Object args) {
//		log.trace "Setting ${name} with ${args} ..."
		if(name in DefaultDsl.metaClass.properties.name)
			DefaultDsl.metaClass.setProperty(this, name, args)
		else if(name in DefaultContext.metaClass.properties.name)
			DefaultContext.metaClass.setProperty(ctx, name, args)
		else if (ctx.state.containsKey(name))
			ctx.state.put(name,args)
		else throw new MissingPropertyException(name, this.getClass());
	}

	
}

process() {
   new DefaultDsl(ctx.callParams.grailsApplication, ctx.callParams.scriptParams, ctx.callParams.ctx, ctx.callParams.sre)
}
''']).save(failOnError:true)

		// init empty cedit dsl
		def emptyDsl = CeditDsl.findByLabel('EmptyDsl')?:new CeditDsl([label: 'EmptyDsl', closureName: 'cedit', code:'''
import grails.plugin.gscripting.dsl.IContext;

class EmptyDsl implements GroovyInterceptable {
	
	Map scriptParams
	IContext ctx

	public EmptyDsl(Map scriptParams, IContext ctx) {
		this.scriptParams = scriptParams
		this.ctx = ctx
	}
	
}

process() {
   new EmptyDsl(ctx.callParams.scriptParams, ctx.callParams.ctx)
}''']).save(failOnError:true)
		
		// init demo script and template
		def demoScript = CeditScript.findByLabel('ceditDemo')?:new CeditScript([label:'ceditDemo', defaultDSL: defaultDsl, content:'''
cedit(){
		log.debug "ceditDemo called"
		model.data['foo'] = 'bar'
		return true
}''']).save(failOnError:true)
		def demoTemplate = CeditTemplate.findByLabel('ceditDemo')?:new CeditTemplate([label:'ceditDemo', defaultScript: demoScript, content:'''
<h2>Cedit Demo</h2>

<p>
This is the template content! The script "${meta.scriptLabel}"
<g:if test="${meta.scriptFailed}">
	failed
	<g:if test="${'scriptException' in meta}">
    	due to this exception: <br />
        <pre>
        	${meta.scriptException}
        </pre>
    </g:if>
</g:if>
<g:else>
	returned: ${data}
</g:else>
</p>

<h2>Debug</h2>
<h3>data:</h3>
<raw>${data}</raw>
<h3>params:</h3>
<raw>${params}</raw>
<h3>body:</h3>
<raw>${body}</raw>
<h3>session:</h3>
<raw>${session}</raw>
<h3>meta:</h3>
<raw>${meta}</raw>
''']).save(failOnError:true)
	}
	
	def destroy = {
	}
}
