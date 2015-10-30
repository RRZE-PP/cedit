package de.rrze.dynamictaglib

class ScriptInterpretingDSL {

	String label
	String code
	String handler

	Date lastUpdated

    static constraints = {
		label blank: false, unique:true
		code blank:false, maxSize: 512000
    }
}
