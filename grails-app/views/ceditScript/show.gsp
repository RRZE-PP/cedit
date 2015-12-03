
<%@ page import="de.rrze.cedit.CeditScript" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication?.config?.layout?.defaultLayout?:'main'}">
		<g:set var="entityName" value="${message(code: 'ceditScript.label', default: 'CeditScript')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-ceditScript" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="manage" action="manage"><g:message code="default.manage.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-ceditScript" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list ceditScript">

				<g:if test="${ceditScriptInstance?.label}">
				<li class="fieldcontain">
					<span id="label-label" class="property-label"><g:message code="ceditScript.label.label" default="Label" /></span>

						<span class="property-value" aria-labelledby="label-label"><g:fieldValue bean="${ceditScriptInstance}" field="label"/></span>

				</li>
				</g:if>

				<g:if test="${ceditScriptInstance?.content}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="ceditScript.content.label" default="Content" /></span>

						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${ceditScriptInstance}" field="content"/></span>

				</li>
				</g:if>

			</ol>
			<g:form url="[resource:ceditScriptInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="manage" resource="${ceditScriptInstance}"><g:message code="default.button.manage.label" default="Manage" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
