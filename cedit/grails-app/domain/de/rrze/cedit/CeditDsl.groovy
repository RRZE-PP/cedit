package de.rrze.cedit

class CeditDsl {

	String label
	String code
	String closureName //calling this 'handler' somehow breaks grails beyond believ

	Date lastUpdated

	//For cmeditor
	String fileType
	String folder

    static constraints = {
		label blank: false, unique:true
		code blank:false, maxSize: 512000
		closureName blank:false
		folder nullable:true
    }
}
