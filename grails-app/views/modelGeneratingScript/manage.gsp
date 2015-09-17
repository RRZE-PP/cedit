<%@ page import="de.rrze.dynamictaglib.ModelGeneratingScript" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'modelGeneratingScript.label', default: 'ModelGeneratingScript')}" />
		<title><g:message code="default.manage.label" args="[entityName]" /></title>
		<asset:javascript src="cmeditor.js"/>
		<asset:stylesheet href="cmeditor.css"/>
	</head>
	<body>
		<a href="#manage-modelGeneratingScript" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="manage-modelGeneratingScript" class="content" role="main">
			<h1><g:message code="default.manage.label" args="[entityName]" /></h1>

			<cmeditor:tabs name="modelgeneratingscript"
				ajax='[listURL: "${createLink(action: "cmeditor_list")}",
				      getURL:    "${createLink(action: "cmeditor_open")}",
				      updateURL: "${createLink(action: "cmeditor_save")}",
				      deleteURL: "${createLink(action: "cmeditor_delete")}"]'
				mapping="[name: 'label']"
				options="[defaultContent: 'process(){[someKey:1337]}']">
			</cmeditor:tabs>

			<script type="text/javascript">
				CMEditor.on("postInitialization", function(rootElem, options, instanceName){
					this.open(${modelGeneratingScriptInstance?.id})
				});
			</script>
		</div>
	</body>
</html>
