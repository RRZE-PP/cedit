import de.rrze.cedit.ModelDisplayingTemplate
import de.rrze.cedit.ModelGeneratingScript
import de.rrze.cedit.ScriptInterpretingDSL

class BootStrap {

	def init = { servletContext ->

		def dsl = new ScriptInterpretingDSL([label:"testDSL", closureName: "dashboard", code:'''
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
			])

	new ScriptInterpretingDSL([label: "PersonDSL", closureName: "Person", code:"""
			class PersonDSL {

    String surname
    String firstname

	def surname(String name){
    	this.surname = name
    }

    def firstname(String name){
    	this.firstname = name
    }
}


process()
{
   new PersonDSL()
}"""]).save(failOnError:true)
		dsl.save(failOnError:true)
		def foo = new ModelGeneratingScript([label:"test", content:"dashboard(){data['testKey'] = 'testVal'}", defaultDSL: dsl])
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
