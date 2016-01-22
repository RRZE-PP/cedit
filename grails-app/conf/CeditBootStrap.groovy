import de.rrze.cedit.CeditTemplate;
import de.rrze.cedit.CeditScript
import de.rrze.cedit.CeditDsl

class CeditBootStrap {

	def grailsApplication

	def init = { servletContext ->
		def defaultDSLContent     = this.class.classLoader.getResourceAsStream('bootstrappedFileContents/DefaultDSL.groovy_').getText()
		def emptyDSLContent       = this.class.classLoader.getResourceAsStream('bootstrappedFileContents/EmptyDSL.groovy_').getText()
		def demoScriptContent     = this.class.classLoader.getResourceAsStream('bootstrappedFileContents/DemoScript.groovy_').getText()
		def demoTemplateContent   = this.class.classLoader.getResourceAsStream('bootstrappedFileContents/DemoTemplate.gsp_').getText()

		def defaultDsl = CeditDsl.findByLabel('DefaultDsl')?:new CeditDsl([label:'DefaultDsl',
		                                                                   closureName: 'cedit',
		                                                                   code:defaultDSLContent,
		                                                                   fileType:"text/x-groovy"]).save(failOnError:true)
		def emptyDsl = CeditDsl.findByLabel('EmptyDsl')?:new CeditDsl([label: 'EmptyDsl',
		                                                               closureName: 'cedit',
		                                                               code:emptyDSLContent,
		                                                               fileType:"text/x-groovy"]).save(failOnError:true)
		def demoScript = CeditScript.findByLabel('ceditDemoScript')?:new CeditScript([label:'ceditDemoScript',
		                                                                              defaultDSL: defaultDsl,
		                                                                              content:demoScriptContent,
		                                                                              fileType:"text/x-groovy"]).save(failOnError:true)
		def demoTemplate = CeditTemplate.findByLabel('ceditDemoTemplate')?:new CeditTemplate([label:'ceditDemoTemplate',
		                                                                                      defaultScript: demoScript,
		                                                                                      content:demoTemplateContent,
		                                                                                      fileType:"application/x-ejs"]).save(failOnError:true)
	}

	def destroy = {
	}
}
