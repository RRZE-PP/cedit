<%@ page import="de.rrze.dynamictaglib.ModelDisplayingTemplate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'modelDisplayingTemplate.label', default: 'ModelDisplayingTemplate')}" />
		<title><g:message code="default.manage.label" args="[entityName]" /></title>
		<asset:javascript src="cmeditor.js"/>
		<asset:stylesheet href="cmeditor.css"/>
	</head>
	<body>
		<a href="#manage-modelDisplayingTemplate" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="manage-modelDisplayingTemplate" class="content" role="main">
			<h1><g:message code="default.manage.label" args="[entityName]" /></h1>

			<cmeditor:tabs name="modeldisplayingtemplate"
				ajax='[listURL: "${createLink(action: "cmeditor_list")}",
				      getURL:    "${createLink(action: "cmeditor_open")}",
				      updateURL: "${createLink(action: "cmeditor_save")}",
				      deleteURL: "${createLink(action: "cmeditor_delete")}"]'
				mapping="[name: 'label']">
				<label for="defaultScript">
					<g:message code="modelDisplayingTemplate.defaultScript.label" default="Default Script" />

				</label>
				<g:select id="defaultScript" name="defaultScript.id" from="${de.rrze.dynamictaglib.ModelGeneratingScript.list()}" optionKey="id" value="${modelDisplayingTemplateInstance?.defaultScript?.id}" class="cmeditor-field many-to-one" noSelection="['': '']"/>
			</cmeditor:tabs>

			<script type="text/javascript">
				CMEditor.on("postInitialization", function(rootElem, options, instanceName){
					this.open(${modelDisplayingTemplateInstance?.id})
				});
			</script>
		</div>
	</body>
</html>
