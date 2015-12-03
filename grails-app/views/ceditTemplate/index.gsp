
<%@ page import="de.rrze.cedit.CeditTemplate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication?.config?.layout?.defaultLayout?:'main'}">
		<g:set var="entityName" value="${message(code: 'ceditTemplate.label', default: 'ceditTemplate')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-ceditTemplate" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="manage" action="manage"><g:message code="default.manage.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-ceditTemplate" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="label" title="${message(code: 'ceditTemplate.label.label', default: 'Label')}" />
					
						<g:sortableColumn property="content" title="${message(code: 'ceditTemplate.content.label', default: 'Content')}" />
					
						<th><g:message code="ceditTemplate.defaultScript.label" default="Default Script" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${ceditTemplateInstanceList}" status="i" var="ceditTemplateInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${ceditTemplateInstance.id}">${fieldValue(bean: ceditTemplateInstance, field: "label")}</g:link></td>
					
						<td>${fieldValue(bean: ceditTemplateInstance, field: "content")}</td>
					
						<td>${fieldValue(bean: ceditTemplateInstance, field: "defaultScript")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${ceditTemplateInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
