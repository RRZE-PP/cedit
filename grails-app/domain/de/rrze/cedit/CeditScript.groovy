package de.rrze.cedit

class CeditScript {
	String  label
	String  content

	CeditDsl defaultDSL

	Date lastUpdated

	static constraints = {
		label blank:false, unique:true
		content blank:false,  maxSize: 512000
		defaultDSL nullable: true
	}
}
