package de.rrze.dynamictaglib

class PinTagLib {
	static defaultEncodeAs = [taglib:'none']

	static namespace = "dynTl"

	//autowired beans
	def gscriptingService
	def groovyPagesTemplateEngine

	static cachedScriptEnvironments = [:]

	def templ = { attrs, body ->

		def template = null
		def script = null
		def availableParameters =  ["attrs": attrs, "body": body(), "params": params, "session": session]
		def origData = ["attrs": attrs.clone(), "body": body(), "params": params.clone()]

		if("id" in attrs)
			template = ModelDisplayingTemplate.get(attrs.id)
		else
			template = ModelDisplayingTemplate.findByLabel(attrs.label)

		if("scriptId" in attrs)
			script = ModelGeneratingScript.get(id)
		else if("scriptLabel" in attrs)
			script = ModelGeneratingScript.findByLabel(attrs.scriptLabel)
		else
			script = template?.defaultScript

		//check for errors
		if(!template){
			out << "<!-- Error: unknown template! Could not render the element -->";
			return
		}

		if(!script && template.script != ModelDisplayingTemplate.NOSCRIPT){
			out << "<!-- Warning: no script passed to template, but no no-script value found! -->"
		}

		//create and store script environment and run script
		if(script && script != ModelDisplayingTemplate.NOSCRIPT){
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

		//store original data (unchanged by script, guaranteed)
		availableParameters["origData"] = origData

		def resultSW = new StringWriter()
		def result = ""
		groovyPagesTemplateEngine
				.createTemplate(new ByteArrayInputStream(template.content.getBytes()))
				.make(availableParameters)
				.writeTo(resultSW)

		out << resultSW.toString()
		resultSW.close()
	}
}
