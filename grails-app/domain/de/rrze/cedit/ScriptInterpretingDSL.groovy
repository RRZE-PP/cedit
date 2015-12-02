package de.rrze.cedit

class ScriptInterpretingDSL {

	String label
	String code
	String closureName //calling this 'handler' somehow breaks grails beyond believ

	Date lastUpdated

    static constraints = {
		label blank: false, unique:true
		code blank:false, maxSize: 512000
		closureName blank:false
    }
}
