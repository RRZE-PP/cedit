<%@ page import="de.rrze.dynamictaglib.ModelGeneratingScript" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'scriptInterpretingDSL.label', default: 'ModelGeneratingScript')}" />
		<title><g:message code="default.manage.label" args="[entityName]" /></title>
		<asset:javascript src="cmeditor.js"/>
		<asset:stylesheet href="cmeditor.css"/>
	</head>
	<body>
		<a href="#manage-scriptInterpretingDSL" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="manage-scriptInterpretingDSL" class="content" role="main">
			<h1><g:message code="default.manage.label" args="[entityName]" /></h1>

			<cmeditor:tabs name="scriptinterpretingdsl"
				ajax='[listURL: "${createLink(action: "cmeditor_list")}",
				      getURL:    "${createLink(action: "cmeditor_open")}",
				      updateURL: "${createLink(action: "cmeditor_save")}",
				      deleteURL: "${createLink(action: "cmeditor_delete")}"]'
				mapping="[name: 'label', content: 'code']"
				options="[defaultMode:'groovy']">
				<g:message code="scriptInterpretingDSL.handler.label" default="Handler" />: <input type="text" class="cmeditor-field" name="handler" />
			</cmeditor:tabs>

			<script type="text/javascript">
				CMEditor.on("postInitialization", function(rootElem, options, instanceName){
					this.open(${scriptInterpretingDSLInstance?.id})
				});
			</script>
		</div>
	</body>
</html>
