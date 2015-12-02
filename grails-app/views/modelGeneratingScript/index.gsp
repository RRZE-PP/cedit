
<%@ page import="de.rrze.cedit.ModelGeneratingScript" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'modelGeneratingScript.label', default: 'ModelGeneratingScript')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-modelGeneratingScript" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="manage" action="manage"><g:message code="default.manage.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-modelGeneratingScript" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>

						<g:sortableColumn property="label" title="${message(code: 'modelGeneratingScript.label.label', default: 'Label')}" />

						<g:sortableColumn property="content" title="${message(code: 'modelGeneratingScript.content.label', default: 'Content')}" />

					</tr>
				</thead>
				<tbody>
				<g:each in="${modelGeneratingScriptInstanceList}" status="i" var="modelGeneratingScriptInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td><g:link action="show" id="${modelGeneratingScriptInstance.id}">${fieldValue(bean: modelGeneratingScriptInstance, field: "label")}</g:link></td>

						<td>${fieldValue(bean: modelGeneratingScriptInstance, field: "content")}</td>

					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${modelGeneratingScriptInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
