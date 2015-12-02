<%@ page import="de.rrze.cedit.ModelGeneratingScript" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication?.config?.layout?.defaultLayout?:'main'}">
		<g:set var="entityName" value="${message(code: 'modelGeneratingScript.label', default: 'ModelGeneratingScript')}" />
		<title><g:message code="default.manage.label" args="[entityName]" /></title>
		<asset:javascript src="cmeditor.js"/>
		<asset:stylesheet href="cmeditor.css"/>
	</head>
	<body>
		<a href="#manage-modelGeneratingScript" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<g:render template="editor"/>
	</body>
</html>
