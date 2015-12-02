<div id="manage-modelDisplayingTemplate" class="content" role="main">
	<h1><g:message code="default.manage.label" args="[entityName]" /></h1>

	<cmeditor:tabs name="modeldisplayingtemplate"
		ajax='[listURL: "${createLink(controller: "ModelDisplayingTemplate", action: "cmeditor_list")}",
		      getURL:    "${createLink(controller: "ModelDisplayingTemplate", action: "cmeditor_open")}",
		      updateURL: "${createLink(controller: "ModelDisplayingTemplate", action: "cmeditor_save")}",
		      deleteURL: "${createLink(controller: "ModelDisplayingTemplate", action: "cmeditor_delete")}"]'
		mapping="[name: 'label']">
		<label for="defaultScript">
			<g:message code="modelDisplayingTemplate.defaultScript.label" default="Default Script" />
		</label>
		<g:select id="defaultScript" name="defaultScript.id" from="${de.rrze.cedit.ModelGeneratingScript.list()}" optionKey="id" optionValue="${{it?.label}}" value="${modelDisplayingTemplateInstance?.defaultScript?.id}" class="cmeditor-field many-to-one" noSelection="['': '']"/>

		<a href="#" title="${message(code: 'de.rrze.cedit.modeldisplayingtemplate.reloadscriptlist', default: 'Refresh script list')}" onclick="refreshScriptList(); return false">⟳</a>
		<a href="#" title="${message(code: 'de.rrze.cedit.modeldisplayingtemplate.editcurrentscript', default: 'Open this script for editing')}" onclick="openScriptForEditing();">✎</a>

	</cmeditor:tabs>

	<script type="text/javascript">
		CMEditor.on("postInitialization", function(rootElem, options, instanceName){
			//open specific template on loading if one is specified in the url
			this.open(${modelDisplayingTemplateInstance?.id});

			var editor = CMEditor.getInstance("modeldisplayingtemplate");
			var actions = editor.menu.addRootMenuEntry("Actions");
			editor.menu.addSubMenuEntry(actions, "Preview (native)", function(){
				var curId = editor.getCurDoc().idField;

				if(curId === null){
					editor.displayMessage("The document has to be saved before preview");
					return;
				}

				var win = window.open('${createLink(controller: "ModelDisplayingTemplate", action: "preview")}'+'/'+curId+'?csrf-token=${session["csrf-token"]}', 'Preview', "height=400,width=400");
				win.focus();
			});
			editor.menu.addSubMenuEntry(actions, "Preview (inline)", function(){
				var curId = editor.getCurDoc().idField;

				if(curId === null){
					editor.displayMessage("The document has to be saved before preview");
					return;
				}

				$.ajax('${createLink(controller: "ModelDisplayingTemplate", action: "preview")}'+'/'+curId+'?csrf-token=${session["csrf-token"]}', {dataType:"html"})
					.done(function(data){
						$("<div/>").append($(data).filter(".content")).dialog();
					})
					.fail(function(){
						editor.displayMessage("The preview could not be rendered");
					});
			});
			editor.menu.addSubMenuEntry(actions, "Refresh script list", refreshScriptList);
		});


		function refreshScriptList(){
			$.ajax('${createLink(action: "cmeditor_list", controller: "ModelGeneratingScript")}')
				.done(function(data){
					if(data.status && data.status === "success"){
						var list = $("#defaultScript");
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
							CMEditor.getInstance("modeldisplayingtemplate").displayMessage("The previously set script is no longer available, the value was cleared!");
							list.val("")
						}
					}else{
						CMEditor.getInstance("modeldisplayingtemplate").displayMessage("Could not refresh list: " + data.msg);
					}
				})
				.fail(function(jqXHR, textStatus, errorThrown){
					CMEditor.getInstance("modeldisplayingtemplate").displayMessage("Could not refresh list: " + textStatus);
				})
		}

		function openScriptForEditing(){
			var scriptId = $("#defaultScript").val();

			if(scriptId === "" || scriptId === null)
				return;

			CMEditor.getInstance("modelgeneratingscript").open(scriptId);
		}
	</script>
</div>