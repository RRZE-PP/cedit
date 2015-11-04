<div id="manage-modelGeneratingScript" class="content" role="main">
	<h1><g:message code="default.manage.label" args="[entityName]" /></h1>

	<cmeditor:tabs name="modelgeneratingscript"
		ajax='[listURL: "${createLink(controller: "modelGeneratingScript", action: "cmeditor_list")}",
		      getURL:    "${createLink(controller: "modelGeneratingScript", action: "cmeditor_open")}",
		      updateURL: "${createLink(controller: "modelGeneratingScript", action: "cmeditor_save")}",
		      deleteURL: "${createLink(controller: "modelGeneratingScript", action: "cmeditor_delete")}"]'
		mapping="[name: 'label']"
		options="[defaultContent: 'process(){[someKey:1337]}']">
	</cmeditor:tabs>

	<script type="text/javascript">
		CMEditor.on("postInitialization", function(rootElem, options, instanceName){
			this.open(${modelGeneratingScriptInstance?.id})
		});
	</script>
</div>