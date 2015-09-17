
<%@ page import="de.rrze.dynamictaglib.ModelDisplayingTemplate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'modelDisplayingTemplate.label', default: 'ModelDisplayingTemplate')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-modelDisplayingTemplate" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="manage" action="manage"><g:message code="default.manage.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-modelDisplayingTemplate" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list modelDisplayingTemplate">
			
				<g:if test="${modelDisplayingTemplateInstance?.label}">
				<li class="fieldcontain">
					<span id="label-label" class="property-label"><g:message code="modelDisplayingTemplate.label.label" default="Label" /></span>
					
						<span class="property-value" aria-labelledby="label-label"><g:fieldValue bean="${modelDisplayingTemplateInstance}" field="label"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${modelDisplayingTemplateInstance?.content}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="modelDisplayingTemplate.content.label" default="Content" /></span>
					
						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${modelDisplayingTemplateInstance}" field="content"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${modelDisplayingTemplateInstance?.defaultScript}">
				<li class="fieldcontain">
					<span id="defaultScript-label" class="property-label"><g:message code="modelDisplayingTemplate.defaultScript.label" default="Default Script" /></span>
					
						<span class="property-value" aria-labelledby="defaultScript-label"><g:link controller="modelGeneratingScript" action="show" id="${modelDisplayingTemplateInstance?.defaultScript?.id}">${modelDisplayingTemplateInstance?.defaultScript?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:modelDisplayingTemplateInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="manage" resource="${modelDisplayingTemplateInstance}"><g:message code="default.button.manage.label" default="Manage" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
