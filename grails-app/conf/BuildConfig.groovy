grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"


grails.project.dependency.resolver = "maven"
grails.project.dependency.resolution = {

	inherits("global")
	log "warn"

	repositories {
		grailsCentral()
		mavenLocal()
		mavenCentral()
	}

	plugins {
		build(":tomcat:7.0.55.2"){
			export = false
		}
		
		build(":release:3.1.0", ":rest-client-builder:2.1.0") {
			export = false
		}

		compile(":scaffolding:2.1.2", ':cache:1.1.8', ":asset-pipeline:2.1.5"){
			export = false
		}

		runtime (":hibernate4:4.3.8.1",
				 ":database-migration:1.4.0",
				 ":jquery:1.11.1"){
			export = false;
		}

		compile ":gscripting:0.0.3"
		compile ":cmeditor:latest.release"
	}
}
