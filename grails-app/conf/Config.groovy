//this is needed for utf-8 characters on some management pages, don't ask me why
grails.mime.types = [all: '*/*']

//this is needed so that the respond method correctly injects instances in GSPs
//please don't ask either. had to figure this out by trial and error.
grails.scaffolding.templates.domainSuffix = 'Instance'

// log4j configuration
log4j.main = {
    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
}
