<div id="manage-ceditScript" class="content" role="main">
	<h1><g:message code="default.manage.label" args="[entityName]" /></h1>

	<cmeditor:tabs name="ceditscript"
		ajax='[listURL: "${createLink(controller: "ceditScript", action: "cmeditor_list")}",
		      getURL:    "${createLink(controller: "ceditScript", action: "cmeditor_open")}",
		      updateURL: "${createLink(controller: "ceditScript", action: "cmeditor_save")}",
		      deleteURL: "${createLink(controller: "ceditScript", action: "cmeditor_delete")}"]'
		mapping="[name: 'label']"
		options='[defaultContent: "dashboard(){ data.someKey = 1337; }", defaultMode:"text/x-groovy"]'>

		<label for="defaultDSL">
			<g:message code="ceditTemplate.defaultDSL.label" default="Default DSL" />
		</label>
		<g:select id="defaultDSL" name="defaultDSL.id" from="${de.rrze.cedit.CeditDsl.list()}" optionKey="id" optionValue="${{it?.label}}" value="${ceditScriptInstance?.defaultDSL?.id}" class="cmeditor-field many-to-one" noSelection="['': '']"/>

		<a href="#" title="${message(code: 'de.rrze.cedit.ceditscript.reloaddsllist', default: 'Refresh DSL list')}" onclick="refreshDSLList(); return false">⟳</a>
		<a href="#" title="${message(code: 'de.rrze.cedit.ceditscript.editcurrentscript', default: 'Open this DSL for editing')}" onclick="openDSLForEditing();"  class="quickOpenLink" style="display:none">✎</a>

	</cmeditor:tabs>

	<script type="text/javascript">
		CMEditor.on("postInitialization", function(rootElem, options, instanceName){
			this.open(${ceditScriptInstance?.id})
		});


		function refreshDSLList(){
			$.ajax('${createLink(action: "cmeditor_list", controller: "ceditDsl")}')
				.done(function(data){
					if(data.status && data.status === "success"){
						var list = $("#defaultDSL");
						var listValue = list.val();

						list.children().remove();
						list.append($("<option/>"))
						for(var i=0; i<data.result.length; i++){
							var result = data.result[i];
							var o = $("<option/>").attr("value", result.id).text(result.label);
							list.append($("<option/>").attr("value", result.id).text(result.label))
						}

						list.val(listValue);

						if(list.val() !== listValue){
							CMEditor.getInstance("ceditscript").displayMessage("The previously set dsl is no longer available, the value was cleared!");
							list.val("")
						}
					}else{
						CMEditor.getInstance("ceditscript").displayMessage("Could not refresh list: " + data.msg);
					}
				})
				.fail(function(jqXHR, textStatus, errorThrown){
					CMEditor.getInstance("ceditscript").displayMessage("Could not refresh list: " + textStatus);
				})
		}


		function openDSLForEditing(){
			var dslId = $("#defaultDSL").val();

			if(dslId === "" || dslId === null)
				return;

			CMEditor.getInstance("ceditdsl").open(dslId);
		}
	</script>
</div>