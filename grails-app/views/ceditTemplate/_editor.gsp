
<div id="manage-ceditTemplate" class="content" role="main">
	<h1><g:message code="default.manage.label" args="[entityName]" /></h1>

	<cmeditor:tabs name="cedittemplate"
		ajax='[listURL: "${createLink(controller: "ceditTemplate", action: "cmeditor_list")}",
		      getURL:    "${createLink(controller: "ceditTemplate", action: "cmeditor_open")}",
		      updateURL: "${createLink(controller: "ceditTemplate", action: "cmeditor_save")}",
		      deleteURL: "${createLink(controller: "ceditTemplate", action: "cmeditor_delete")}"]'
		mapping="[name: 'label']">
		<label for="defaultScript">
			<g:message code="ceditTemplate.defaultScript.label" default="Default Script" />
		</label>
		<g:select id="defaultScript" name="defaultScript.id" from="${de.rrze.cedit.CeditScript.list()}" optionKey="id" optionValue="${{it?.label}}" value="${ceditTemplateInstance?.defaultScript?.id}" class="cmeditor-field many-to-one" noSelection="['': '']"/>

		<a href="#" title="${message(code: 'de.rrze.cedit.cedittemplate.reloadscriptlist', default: 'Refresh script list')}" onclick="refreshScriptList(); return false">⟳</a>
		<a href="#" title="${message(code: 'de.rrze.cedit.cedittemplate.editcurrentscript', default: 'Open this script for editing')}"  onclick="openScriptForEditing();" class="quickOpenLink" style="display:none">✎</a>

	</cmeditor:tabs>

	<script type="text/javascript">
		CMEditor.on("postInitialization", function(rootElem, options, instanceName){
			var editor = CMEditor.getInstance("cedittemplate");
			var actions = editor.menu.addRootMenuEntry("Actions");
			editor.menu.addSubMenuEntry(actions, "Preview (native)", function(){
				var curId = editor.getCurDoc().idField;

				if(curId === null){
					editor.displayMessage("The document has to be saved before preview");
					return;
				}

				var win = window.open('${createLink(controller: "ceditTemplate", action: "preview")}'+'/'+curId+'?csrf-token=${session["csrf-token"]}', 'Preview', "height=400,width=400");
				win.focus();
			});
			editor.menu.addSubMenuEntry(actions, "Preview (inline)", function(){
				var curId = editor.getCurDoc().idField;

				if(curId === null){
					editor.displayMessage("The document has to be saved before preview");
					return;
				}

				$.ajax('${createLink(controller: "ceditTemplate", action: "preview")}'+'/'+curId+'?csrf-token=${session["csrf-token"]}', {dataType:"html"})
					.done(function(data){
						$("<div/>").append($(data).filter(".content")).dialog();
					})
					.fail(function(){
						editor.displayMessage("The preview could not be rendered");
					});
			});
			editor.menu.addSubMenuEntry(actions, "Refresh script list", refreshScriptList);
		}, "cedittemplate");


		function refreshScriptList(){
			$.ajax('${createLink(action: "cmeditor_list", controller: "CeditScript")}')
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
							CMEditor.getInstance("cedittemplate").displayMessage("The previously set script is no longer available, the value was cleared!");
							list.val("")
						}
					}else{
						CMEditor.getInstance("cedittemplate").displayMessage("Could not refresh list: " + data.msg);
					}
				})
				.fail(function(jqXHR, textStatus, errorThrown){
					CMEditor.getInstance("cedittemplate").displayMessage("Could not refresh list: " + textStatus);
				})
		}

		function openScriptForEditing(){
			var scriptId = $("#defaultScript").val();

			if(scriptId === "" || scriptId === null)
				return;

			CMEditor.getInstance("ceditscript").open(scriptId);
		}
	</script>
</div>