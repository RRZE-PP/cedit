import de.rrze.dynamictaglib.ModelDisplayingTemplate
import de.rrze.dynamictaglib.ModelGeneratingScript

class BootStrap {

	def init = { servletContext ->

		new ModelGeneratingScript([label:"test", content:"process(){[testKey:'testVal']}"]).save(failOnError:true)
		new ModelDisplayingTemplate([label:"test", content:'This is the content! Script \'${attr["script"]}\' returned: ${testKey}']).save(failOnError:true)
	}
	def destroy = {
	}
}
