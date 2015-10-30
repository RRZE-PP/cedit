import de.rrze.dynamictaglib.ModelDisplayingTemplate
import de.rrze.dynamictaglib.ModelGeneratingScript
import de.rrze.dynamictaglib.ScriptInterpretingDSL

class BootStrap {

	def init = { servletContext ->

		def dsl = new ScriptInterpretingDSL([label:"testDSL", handler: "dashboard", code:'''
import java.text.SimpleDateFormat
import java.util.Date;

import org.apache.commons.logging.LogFactory

import grails.plugin.gscripting.ScriptRuntimeEnv;
import grails.plugin.gscripting.dsl.IContext;
import grails.util.Holders


class DashboardDslInterceptor implements GroovyInterceptable {

	def grailsApplication
	def script
	def log
	def app = [:]

	Map scriptParams
	ScriptRuntimeEnv sre

	DashboardDslInterceptor(ScriptRuntimeEnv sre) {
		this.grailsApplication = Holders.getGrailsApplication()
		this.script = sre?.additionalData
		this.scriptParams = scriptParams
		this.sre = sre

		this.grailsApplication.serviceClasses.each {
			def bean = this.grailsApplication.mainContext.getBean(it.propertyName)
			this.app.put(it.propertyName, bean)
		}

		this.log = LogFactory.getLog("de.rrze.dynamictaglib.${script?.label?.capitalize()}.${script?.id}".toString());
	}

	public Object invokeMethod(String name, Object args) {
		try{
			def calledMethod = DashboardDslInterceptor.metaClass.getMetaMethod(name, args)
			return calledMethod?.invoke(this, args)
		}
		catch(Throwable t){
			t.printStackTrace();
			throw t
		}
	}

	public Object getProperty(String name) {
		if(name in DashboardDslInterceptor.metaClass.properties.name)
			return  DashboardDslInterceptor.metaClass.getProperty(this, name)

		throw new MissingPropertyException(name,this.class)
	}

	void setProperty(String name, args) {
		if(name in DashboardDslInterceptor.metaClass.properties.name)
			DashboardDslInterceptor.metaClass.setProperty(this, name, args)
	}
}

process(dslDefinition:'dashboard')
{
   new DashboardDslInterceptor(__dsl__script)
}
'''
			]).save(failOnError:true)
		def foo = new ModelGeneratingScript([label:"test", content:"process(){[testKey:'testVal']}"])
		foo.save(failOnError:true)
		new ModelDisplayingTemplate([label:"test", content:'This is the content! Script \'${attrs.scriptLabel?attrs.scriptLabel:"defaultScript"}\' returned: ${testKey}', defaultScript: foo]).save(failOnError:true)
	}
	def destroy = {
	}
}
