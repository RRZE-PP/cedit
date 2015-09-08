package de.rrze.dynamictaglib

class ModelGeneratingScript {

	String  label
	String  content

	static constraints = {
		label (nullable:false,
		blank:false,
		unique:true,
		validator: { val ->
			if (val == ModelDisplayingTemplate.NOSCRIPT){
				return [
					'dynamictaglib.reservedLabel'
				]
			}
		}
		)
		content (nullable:false, blank:false,  maxSize: 512000)
	}
}
