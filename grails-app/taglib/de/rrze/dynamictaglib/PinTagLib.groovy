package de.rrze.dynamictaglib

class PinTagLib {
	static defaultEncodeAs = [taglib:'none']

	static namespace = "dynTl"

	//autowired beans
	def gscriptingService
	def groovyPagesTemplateEngine

	static cachedScriptEnvironments = [:]
	static cachedDSLProviders = [:]
	static cachedDSLProvidersPerScript = [:]

	def templ = { attrs, body ->

		//workaround a bug in gscripting by getting the default dsl once before setting our own
		gscriptingService.getDslProvider("default")

		def template = null
		def script = null
		def dsl = null
		def rawData = "data" in attrs ? attrs.data : [:]
		def availableParameters =  ["data": rawData, "params": params, "body": body(), "session": session, "meta": [:]]

		//get the required objects
		if("id" in attrs)
			template = ModelDisplayingTemplate.get(attrs.id)
		else
			template = ModelDisplayingTemplate.findByLabel(attrs.label)

		if("scriptId" in attrs)
			script = ModelGeneratingScript.get(attrs.scriptId)
		else if("scriptLabel" in attrs)
			script = ModelGeneratingScript.findByLabel(attrs.scriptLabel)
		else
			script = template?.defaultScript

		if("dslId" in attrs)
			dsl = ScriptInterpretingDSL.get(attrs.dslId)
		else if("dslLabel" in attrs)
			dsl = ScriptInterpretingDSL.findByLabel(attrs.dslLabel)
		else
			dsl = script?.defaultDSL


		//check for errors
		if(!template)
			throw Exception("Unknown template label or id specified. Cannot render the element.");

		if(!script && ("scriptId" in attrs || "scriptLabel" in attrs))
			throw Exception("Unknown script label or id specified. Cannot create model for template.");

		if(script && dsl == null && ("dslId" in attrs || "dslLabel" in attrs))
			throw Exception("Unknown dsl label or id specified. Cannot create dsl for script.");


		availableParameters.meta["templateId"] = template.id
		availableParameters.meta["templateLabel"] = template.label

		//create and store script environment and run script
		if(script){
			def dslProviderLabel = "default"

			availableParameters.meta["scriptId"] = script.id
			availableParameters.meta["scriptLabel"] = script.label

			//instanciate a DSLProvider, if the script requires a special dsl
			if(dsl != null){
				dslProviderLabel = "de.rrze.dynamictaglib."+dsl.label

				availableParameters.meta["dslId"] = dsl.id
				availableParameters.meta["dslLabel"] = dsl.label

				if(!(dslProviderLabel in cachedDSLProviders) || cachedDSLProviders[dslProviderLabel] < dsl.lastUpdated){
					//possible lost update here!
					cachedDSLProviders[dsl.label] = dsl.lastUpdated
					gscriptingService.registerDslProvider(dslProviderLabel, new DynamicDSLProvider(dsl))
				}
			}

			def envLabel = "de.rrze.dynamictaglib."+script.label

			if(!(envLabel in cachedScriptEnvironments)  //create if new environment
				|| cachedScriptEnvironments[envLabel] < script.lastUpdated //or if the script was updated in the db
				|| cachedDSLProvidersPerScript[envLabel] != dslProviderLabel //or if the dsl provider for this script has changed
				){
					//possible lost update here!
					cachedScriptEnvironments[envLabel] = script.lastUpdated
					cachedDSLProvidersPerScript[envLabel] = dslProviderLabel
					gscriptingService.registerScriptRuntimeEnv(envLabel, script.content, dslProviderLabel)
			}

			try {
				def result = gscriptingService.run(envLabel, availableParameters)
				availableParameters.meta["scriptFailed"] = result == false
			}catch (Exception e){
				availableParameters.meta["scriptFailed"] = true
				availableParameters.meta["scriptException"] = e
			}
		}


		//write the output
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
