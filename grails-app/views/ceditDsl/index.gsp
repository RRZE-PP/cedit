
<%@ page import="de.rrze.cedit.CeditDsl" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication?.config?.layout?.defaultLayout?:'main'}">
		<g:set var="entityName" value="${message(code: 'ceditDsl.label', default: 'ceditdsl')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-ceditDsl" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="manage" action="manage"><g:message code="default.manage.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-ceditDsl" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>

						<g:sortableColumn property="label" title="${message(code: 'ceditDsl.label.label', default: 'Label')}" />

						<g:sortableColumn property="closureName" title="${message(code: 'ceditDsl.handler.label', default: 'Handler')}" />

						<g:sortableColumn property="code" title="${message(code: 'ceditDsl.code.label', default: 'Code')}" />

					</tr>
				</thead>
				<tbody>
				<g:each in="${ceditDslInstanceList}" status="i" var="ceditDslInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td><g:link action="show" id="${ceditDslInstance.id}">${fieldValue(bean: ceditDslInstance, field: "label")}</g:link></td>

						<td>${fieldValue(bean: ceditDslInstance, field: "closureName")}</td>

						<td>${fieldValue(bean: ceditDslInstance, field: "code")}</td>

					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${ceditDslInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
