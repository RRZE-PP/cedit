<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication?.config?.layout?.defaultLayout?:'main'}">
		<title><g:message code="de.rrze.cedit.preview.label" default="Preview template ${ceditTemplateInstance?.label}" /></title>
	</head>
	<body>
		<div id="preview-ceditTemplate" class="content" role="main">
			<h1><g:message code="de.rrze.cedit.preview.label" default="Preview template ${ceditTemplateInstance?.label}" /></h1>

			<cedit:templ label="${ceditTemplateInstance?.label}" />
		</div>
	</body>
</html>
