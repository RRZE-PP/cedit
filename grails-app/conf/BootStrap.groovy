import de.rrze.dynamictaglib.ModelDisplayingTemplate
import de.rrze.dynamictaglib.ModelGeneratingScript

class BootStrap {

	def init = { servletContext ->

		def foo = new ModelGeneratingScript([label:"test", content:"process(){[testKey:'testVal']}"])
		foo.save(failOnError:true)
		new ModelDisplayingTemplate([label:"test", content:'This is the content! Script \'${attr["script"]}\' returned: ${testKey}', defaultScript: foo]).save(failOnError:true)
	}
	def destroy = {
	}
}
