<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication?.config?.layout?.defaultLayout?:'main'}">
		<title><g:message code="de.rrze.dynamictagbli.preview.label" default="Preview template ${modelDisplayingTemplateInstance?.label}" /></title>
	</head>
	<body>
		<div id="manage-modelDisplayingTemplate" class="content" role="main">
			<h1><g:message code="de.rrze.dynamictagbli.preview.label" default="Preview template ${modelDisplayingTemplateInstance?.label}" /></h1>

			<dynTl:templ label="${modelDisplayingTemplateInstance?.label}" />
		</div>
	</body>
</html>
