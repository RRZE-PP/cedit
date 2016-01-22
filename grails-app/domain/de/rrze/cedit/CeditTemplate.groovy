package de.rrze.cedit

class CeditTemplate {
	String label
	String content

	CeditScript defaultScript

	//For cmeditor
	String fileType
	String folder

	static constraints = {
		label blank: false, unique:true
		content blank:false, maxSize: 512000
		defaultScript nullable:true
		folder nullable:true
	}
}
