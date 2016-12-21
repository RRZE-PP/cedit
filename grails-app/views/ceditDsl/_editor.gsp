
<div id="manage-ceditDsl" class="content" role="main">
	<h1><g:message code="default.manage.label" args="[entityName]" /></h1>

	<cmeditor:tabs name="ceditdsl"
		ajax='[listURL: "${createLink(controller:"ceditDsl", action: "cmeditor_list")}",
		      getURL:    "${createLink(controller:"ceditDsl", action: "cmeditor_open")}",
		      updateURL: "${createLink(controller:"ceditDsl", action: "cmeditor_save")}",
		      deleteURL: "${createLink(controller:"ceditDsl", action: "cmeditor_delete")}"]'
		mapping="[name: 'label', content: 'code', mode: 'fileType']"
		options="[defaultMode:'text/x-groovy']">
		<g:message code="ceditDsl.closureName.label" default="Handler" />: <input type="text" class="cmeditor-field" name="closureName" />
	</cmeditor:tabs>
</div>
