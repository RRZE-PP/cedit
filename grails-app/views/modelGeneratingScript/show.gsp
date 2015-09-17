
<%@ page import="de.rrze.dynamictaglib.ModelGeneratingScript" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'modelGeneratingScript.label', default: 'ModelGeneratingScript')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-modelGeneratingScript" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="manage" action="manage"><g:message code="default.manage.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-modelGeneratingScript" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list modelGeneratingScript">

				<g:if test="${modelGeneratingScriptInstance?.label}">
				<li class="fieldcontain">
					<span id="label-label" class="property-label"><g:message code="modelGeneratingScript.label.label" default="Label" /></span>

						<span class="property-value" aria-labelledby="label-label"><g:fieldValue bean="${modelGeneratingScriptInstance}" field="label"/></span>

				</li>
				</g:if>

				<g:if test="${modelGeneratingScriptInstance?.content}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="modelGeneratingScript.content.label" default="Content" /></span>

						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${modelGeneratingScriptInstance}" field="content"/></span>

				</li>
				</g:if>

			</ol>
			<g:form url="[resource:modelGeneratingScriptInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="manage" resource="${modelGeneratingScriptInstance}"><g:message code="default.button.manage.label" default="Manage" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
