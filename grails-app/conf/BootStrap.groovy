import de.rrze.dynamictaglib.ModelDisplayingTemplate
import de.rrze.dynamictaglib.ModelGeneratingScript
import de.rrze.dynamictaglib.ScriptInterpretingDSL

class BootStrap {

	def init = { servletContext ->

		def dsl = new ScriptInterpretingDSL([label:"testDSL", handler: "dashboard", code:'''
class SimpleDSL implements GroovyInterceptable {

	Map params

	SimpleDSL(Map callParams) {
		this.params = callParams
	}

	public Object getProperty(String name) {
      if(this.params.containsKey(name)){
      	return this.params[name]
      }

      throw new MissingPropertyException(name, this.getClass())
	}
}

process()
{
   new SimpleDSL(ctx.callParams)
}
'''
			]).save(failOnError:true)
		def foo = new ModelGeneratingScript([label:"test", content:"process(){[testKey:'testVal']}"])
		foo.save(failOnError:true)
		new ModelDisplayingTemplate([label:"test", content:"""
This is the template content! The script '\${meta.scriptLabel}'

<g:if test="\${meta.scriptFailed}">
	failed
	<g:if test="\${'scriptException' in meta}">
    	due to this exception: <br />
        <pre>
        	\${meta.scriptException}
        </pre>
    </g:if>
</g:if>
<g:else>
	returned: \${data}
</g:else>""", defaultScript: foo]).save(failOnError:true)
	}
	def destroy = {
	}
}
