
<%@ page import="de.rrze.cedit.CeditScript" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication?.config?.layout?.defaultLayout?:'main'}">
		<g:set var="entityName" value="${message(code: 'ceditScript.label', default: 'CeditScript')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-ceditScript" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="manage" action="manage"><g:message code="default.manage.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-ceditScript" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>

						<g:sortableColumn property="label" title="${message(code: 'ceditScript.label.label', default: 'Label')}" />

						<g:sortableColumn property="content" title="${message(code: 'ceditScript.content.label', default: 'Content')}" />

					</tr>
				</thead>
				<tbody>
				<g:each in="${ceditScriptInstanceList}" status="i" var="ceditScriptInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td><g:link action="show" id="${ceditScriptInstance.id}">${fieldValue(bean: ceditScriptInstance, field: "label")}</g:link></td>

						<td>${fieldValue(bean: ceditScriptInstance, field: "content")}</td>

					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${ceditScriptInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
