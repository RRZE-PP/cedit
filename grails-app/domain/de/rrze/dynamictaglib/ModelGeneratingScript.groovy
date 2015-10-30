package de.rrze.dynamictaglib

class ModelGeneratingScript {

	String  label
	String  content
	ScriptInterpretingDSL defaultDSL

	Date lastUpdated

	static constraints = {
		label blank:false, unique:true
		content blank:false,  maxSize: 512000
		defaultDSL nullable: true
	}
}
