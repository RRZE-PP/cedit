
<%@ page import="de.rrze.cedit.CeditDsl" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication?.config?.layout?.defaultLayout?:'main'}">
		<g:set var="entityName" value="${message(code: 'ceditDsl.label', default: 'ceditdsl')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-ceditDsl" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="manage" action="manage"><g:message code="default.manage.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-ceditDsl" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list ceditDsl">

				<g:if test="${ceditDslInstance?.label}">
				<li class="fieldcontain">
					<span id="label-label" class="property-label"><g:message code="ceditDsl.label.label" default="Label" /></span>

						<span class="property-value" aria-labelledby="label-label"><g:fieldValue bean="${ceditDslInstance}" field="label"/></span>

				</li>
				</g:if>

				<g:if test="${ceditDslInstance?.closureName}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="ceditDsl.handler.label" default="Handler" /></span>

						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${ceditDslInstance}" field="closureName"/></span>

				</li>
				</g:if>

				<g:if test="${ceditDslInstance?.code}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="ceditDsl.code.label" default="Code" /></span>

						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${ceditDslInstance}" field="code"/></span>

				</li>
				</g:if>

			</ol>
			<g:form url="[resource:ceditDslInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="manage" resource="${ceditDslInstance}"><g:message code="default.button.manage.label" default="Manage" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
