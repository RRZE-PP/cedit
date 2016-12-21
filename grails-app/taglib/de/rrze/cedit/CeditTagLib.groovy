package de.rrze.cedit

class CeditTagLib {
	static defaultEncodeAs = [taglib:'none']

	static namespace = "cedit"

	//autowired beans
	def gscriptingService
	def groovyPagesTemplateEngine

	static cachedScriptEnvironments = [:]
	static cachedDSLProviders = [:]
	static cachedDSLProvidersPerScript = [:]

	def templ = { attrs, body ->

		//workaround a bug in gscripting by getting the default dsl once before setting our own
		gscriptingService.getDslProvider("default")
		gscriptingService.registerDslProvider("de.rrze.cedit.default", new grails.plugin.gscripting.dsl.impl.DefaultDslProvider(grailsApplication))

		def template = null
		def script = null
		def dsl = null
		def rawData = "data" in attrs ? attrs.data : [:]
		def model =  ["data": rawData, "params": params, "body": body(), "session": session, "meta": [:]]

		//get the required objects
		if("id" in attrs)
			template = CeditTemplate.get(attrs.id)
		else
			template = CeditTemplate.findByLabel(attrs.label)

		if("scriptId" in attrs)
			script = CeditScript.get(attrs.scriptId)
		else if("scriptLabel" in attrs)
			script = CeditScript.findByLabel(attrs.scriptLabel)
		else
			script = template?.defaultScript

		if("dslId" in attrs)
			dsl = CeditDsl.get(attrs.dslId)
		else if("dslLabel" in attrs)
			dsl = CeditDsl.findByLabel(attrs.dslLabel)
		else
			dsl = script?.defaultDSL


		//check for errors
		//if(!template)
			//throw Exception("Unknown template label or id specified. Cannot render the element.");

//		if(!script && ("scriptId" in attrs || "scriptLabel" in attrs))
//			throw Exception("Unknown script label or id specified. Cannot create model for template.");

//		if(script && dsl == null && ("dslId" in attrs || "dslLabel" in attrs))
//			throw Exception("Unknown dsl label or id specified. Cannot create dsl for script.");


		model.meta["templateId"] = template?.id
		model.meta["templateLabel"] = template?.label

		//create and store script environment and run script
		if(script){
			def dslProviderLabel = "de.rrze.cedit.default"

			model.meta["scriptId"] = script.id
			model.meta["scriptLabel"] = script.label

			//instanciate a DSLProvider, if the script requires a special dsl
			if(dsl != null){
				dslProviderLabel = "de.rrze.cedit."+dsl.label

				model.meta["dslId"] = dsl.id
				model.meta["dslLabel"] = dsl.label

				if(!(dslProviderLabel in cachedDSLProviders) || cachedDSLProviders[dslProviderLabel] < dsl.lastUpdated){
					//possible lost update here!
					cachedDSLProviders[dsl.label] = dsl.lastUpdated
					gscriptingService.registerDslProvider(dslProviderLabel, new DynamicDSLProvider(dsl))
				}
			}

			def envLabel = "de.rrze.cedit."+script.label

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
				def result = gscriptingService.run(envLabel, [:], [model:model])
				model.meta["scriptFailed"] = result == false
			}catch (Exception e){
				model.meta["scriptFailed"] = true
				model.meta["scriptException"] = e
			}
		}


		//write the output
		def resultSW = new StringWriter()
		def result = ""
		if (template) {
			groovyPagesTemplateEngine
					.createTemplate(new ByteArrayInputStream(template.content.getBytes()))
					.make(model)
					.writeTo(resultSW)
		}
		out << resultSW.toString()
		resultSW.close()
	}
}
