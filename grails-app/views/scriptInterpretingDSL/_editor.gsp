
<div id="manage-scriptInterpretingDSL" class="content" role="main">
	<h1><g:message code="default.manage.label" args="[entityName]" /></h1>

	<cmeditor:tabs name="scriptinterpretingdsl"
		ajax='[listURL: "${createLink(controller:"scriptInterpretingDSL", action: "cmeditor_list")}",
		      getURL:    "${createLink(controller:"scriptInterpretingDSL", action: "cmeditor_open")}",
		      updateURL: "${createLink(controller:"scriptInterpretingDSL", action: "cmeditor_save")}",
		      deleteURL: "${createLink(controller:"scriptInterpretingDSL", action: "cmeditor_delete")}"]'
		mapping="[name: 'label', content: 'code']"
		options="[defaultMode:'text/x-groovy']">
		<g:message code="scriptInterpretingDSL.handler.label" default="Handler" />: <input type="text" class="cmeditor-field" name="handler" />
	</cmeditor:tabs>

	<script type="text/javascript">
		CMEditor.on("postInitialization", function(rootElem, options, instanceName){
			this.open(${scriptInterpretingDSLInstance?.id})
		});
	</script>
</div>