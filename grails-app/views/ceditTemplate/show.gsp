
<%@ page import="de.rrze.cedit.CeditTemplate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication?.config?.layout?.defaultLayout?:'main'}">
		<g:set var="entityName" value="${message(code: 'ceditTemplate.label', default: 'ceditTemplate')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-ceditTemplate" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="manage" action="manage"><g:message code="default.manage.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-ceditTemplate" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list ceditTemplate">

				<g:if test="${ceditTemplateInstance?.label}">
				<li class="fieldcontain">
					<span id="label-label" class="property-label"><g:message code="ceditTemplate.label.label" default="Label" /></span>

						<span class="property-value" aria-labelledby="label-label"><g:fieldValue bean="${ceditTemplateInstance}" field="label"/></span>

				</li>
				</g:if>

				<g:if test="${ceditTemplateInstance?.content}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="ceditTemplate.content.label" default="Content" /></span>

						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${ceditTemplateInstance}" field="content"/></span>

				</li>
				</g:if>

				<g:if test="${ceditTemplateInstance?.defaultScript}">
				<li class="fieldcontain">
					<span id="defaultScript-label" class="property-label"><g:message code="ceditTemplate.defaultScript.label" default="Default Script" /></span>

						<span class="property-value" aria-labelledby="defaultScript-label"><g:link controller="ceditScript" action="show" id="${ceditTemplateInstance?.defaultScript?.id}">${ceditTemplateInstance?.defaultScript?.encodeAsHTML()}</g:link></span>

				</li>
				</g:if>

			</ol>
			<g:form url="[resource:ceditTemplateInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="manage" resource="${ceditTemplateInstance}"><g:message code="default.button.manage.label" default="Manage" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
