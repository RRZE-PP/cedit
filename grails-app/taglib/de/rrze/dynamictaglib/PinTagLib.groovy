package de.rrze.dynamictaglib

class PinTagLib {
	static defaultEncodeAs = [taglib:'none']

	static namespace = "dynTl"

	//autowired beans
	def gscriptingService
	def groovyPagesTemplateEngine

	static cachedScriptEnvironments = [:]

	def dynamicElem = { attrs, body ->

		def template = ModelDisplayingTemplate.findByLabel(attrs.template)
		def script = "script" in attrs ? ModelGeneratingScript.findByLabel(attrs.script) : template?.defaultScript
		def availableParameters =  ["attr": attrs, "body": body(), "params": params, "session": session]

		if(!template){
			out << "<!-- Error: unknown template! Could not render the dynamicElem -->";
			return
		}

		if(!script && script.label != ModelDisplayingTemplate.NOSCRIPT){
			out << "<!-- Warning: no script passed to template, but no no-script value found! -->"
		}

		if(script && script.label != ModelDisplayingTemplate.NOSCRIPT){
			def envLabel = "de.rrze.dynamictaglib."+script.label

			if(!(envLabel in cachedScriptEnvironments) || cachedScriptEnvironments[envLabel] < script.lastUpdated){
				//possible lost update here!
				cachedScriptEnvironments[envLabel] = script.lastUpdated
				gscriptingService.registerScriptRuntimeEnv(envLabel, script.content)
			}

			def model = gscriptingService.run(envLabel, availableParameters)
			if(model != null)
				availableParameters.putAll(model)
		}

		def resultSW = new StringWriter()
		def result = ""
		groovyPagesTemplateEngine
				.createTemplate(new ByteArrayInputStream(template.content.getBytes()))
				.make(availableParameters)
				.writeTo(resultSW)

		out << resultSW.toString()
		resultSW.close()
	}

	//for backwards-compatability
	def pin = dynamicElem;
}
