package de.rrze.dynamictaglib

class PinTagLib {
	static defaultEncodeAs = [taglib:'none']

	static namespace = "dynTl"

	def gscriptingService
	def groovyPagesTemplateEngine

	def dynamicElem = { attrs, body ->

		def template = ModelDisplayingTemplate.findByLabel(attrs.template)
		def script = "script" in attrs ? ModelGeneratingScript.findByLabel(attrs.script) : template?.defaultScript
		def availableParameters =  ["attr": attrs, "body": body(), "params": params, "session": session]

		if(!template){
			out << "<!-- Error: unknown template! Could not render the dynamicElem -->";
			return
		}

		if(!script && script != ModelDisplayingTemplate.NOSCRIPT){
			out << "<!-- Warning: no script passed to template, but no no-script value found! -->"
		}

		if(script && script != ModelDisplayingTemplate.NOSCRIPT){
			//todo: irgendwie zwischenspeichern? registerScriptRuntimeEnv nutzen?
			def sre = gscriptingService.createScriptRuntimeEnv("de.rrze.dynamictaglib."+script.label, script.content)
			def model = sre.run(availableParameters)
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
