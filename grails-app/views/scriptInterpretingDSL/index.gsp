
<%@ page import="de.rrze.cedit.ScriptInterpretingDSL" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'scriptInterpretingDSL.label', default: 'ScriptInterpretingDSL')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-scriptInterpretingDSL" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="manage" action="manage"><g:message code="default.manage.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-scriptInterpretingDSL" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>

						<g:sortableColumn property="label" title="${message(code: 'scriptInterpretingDSL.label.label', default: 'Label')}" />

						<g:sortableColumn property="handler" title="${message(code: 'scriptInterpretingDSL.handler.label', default: 'Handler')}" />

						<g:sortableColumn property="code" title="${message(code: 'scriptInterpretingDSL.code.label', default: 'Code')}" />

					</tr>
				</thead>
				<tbody>
				<g:each in="${scriptInterpretingDSLInstanceList}" status="i" var="scriptInterpretingDSLInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td><g:link action="show" id="${scriptInterpretingDSLInstance.id}">${fieldValue(bean: scriptInterpretingDSLInstance, field: "label")}</g:link></td>

						<td>${fieldValue(bean: scriptInterpretingDSLInstance, field: "handler")}</td>

						<td>${fieldValue(bean: scriptInterpretingDSLInstance, field: "code")}</td>

					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${scriptInterpretingDSLInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
