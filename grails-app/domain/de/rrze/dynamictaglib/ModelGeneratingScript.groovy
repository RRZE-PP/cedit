package de.rrze.dynamictaglib

class ModelGeneratingScript {

	String  label
	String  content

	Date lastUpdated

	static constraints = {
		label (nullable:false,
		blank:false,
		unique:true
		)
		content (nullable:false, blank:false,  maxSize: 512000)
	}
}
