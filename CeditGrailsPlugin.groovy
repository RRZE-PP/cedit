class CeditGrailsPlugin {
    def version = "0.1.0"
    def grailsVersion = "2.5 > *"
    def pluginExcludes = [
        "grails-app/views/error.gsp"
    ]
    def title = "Cedit Plugin"
	def author = "Frank Tröger"
	def authorEmail = "frank.troeger@fau.de"
	def description = 'Brief summary/description of the plugin.' //TODO
	def documentation = "https://github.com/RRZE-PP/grails-cedit"
	def license = "APACHE"
	def organization = [ name: "RRZE", url: "http://www.rrze.de/" ]
	def developers = [ [ name: "t-animal", email: "tilman.adler@fau.de" ] ]
	def issueManagement = [ system: "GITHUB", url: "https://github.com/RRZE-PP/grails-cedit/issues" ]
	def scm = [ url: "https://github.com/RRZE-PP/grails-cedit" ]
}
