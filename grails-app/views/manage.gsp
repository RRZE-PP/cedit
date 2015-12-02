<%@ page import="de.rrze.cedit.ModelGeneratingScript" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="${grailsApplication?.config?.layout?.defaultLayout?:'main'}">
		<g:set var="entityName" value="${message(code: 'appname', default: 'Cedit')}" />
		<title><g:message code="default.manage.label" args="[entityName]" /></title>
		<asset:javascript src="cmeditor.js"/>
		<asset:stylesheet href="cmeditor.css"/>
	</head>
	<body>
		<a href="#manage-scriptInterpretingDSL" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><a id="directionSwitch" role="button" href="#">⇔ <g:message code="de.rrze.cedit.manage.directionSwitch" default="Switch layout"/></a></li>
			</ul>
		</div>

		<style>
		#flexContainer h1::after {
			content: "↹";
			padding-left: 3mm;
			cursor: pointer;
		}

		.sortablePlaceholder {
			height:400px;
			width:500px;
			/*margin:5px;*/
			margin-top:50px;
			background-color:#eee;
			border:1px solid #ccc;
			border-radius: 3px;
			box-sizing: border-box;
			min-height:200px;
		}
		</style>
		<div id="flexContainer" style="display:flex; flex-wrap:wrap; flex-direction: column;">

		<g:set var="entityName" value="${message(code: 'modelDisplayingTemplate.label', default: 'ModelDisplayingTemplate')}" />
			<g:render template="modelDisplayingTemplate/editor" />
		<g:set var="entityName" value="${message(code: 'modelGeneratingScript.label', default: 'ModelGeneratingScript')}" />
			<g:render template="modelGeneratingScript/editor" />
		<g:set var="entityName" value="${message(code: 'scriptInterpretingDSL.label', default: 'ScriptInterpretingDSL')}" />
			<g:render template="scriptInterpretingDSL/editor" />
		</div>

		<script>
			$("#manage-modelDisplayingTemplate").resizable({
				containment: "#flexContainer",
				handles: "e",
				minWidth: 490
			});
			$("#manage-modelGeneratingScript").resizable({
				containment: "#flexContainer",
				handles: "e",
				minWidth: 390
			});
			$("#manage-scriptInterpretingDSL").resizable({
				containment: "#flexContainer",
				handles: "e",
				minWidth: 390
			});
			$("#flexContainer").sortable({
				handle: "h1",
				tolerance: "pointer",
				placeholder: "sortablePlaceholder",
				forcePlaceholderSize: true
				}).on("sortstart", function( event, ui ) {
						ui.placeholder.css({"height": "auto",
											"min-height": ui.item.find(".cmeditor").height(),
											"margin-top": ui.item.find("h1").outerHeight(true)})
						ui.placeholder.width(ui.item.width())
				});

			$("#directionSwitch").on("click", function(evt){
				var c = $("#flexContainer");
				if(c.css("flex-direction") === "row"){
					c.children().each(function(idx){
						var elem = $(this);
						elem.attr("data-oldWith", Math.ceil(parseFloat(window.getComputedStyle(this).width)));
					});
					c.css("flex-direction", "column");
					c.children().width("auto");
				}else{
					c.css("flex-direction", "row");
					c.children().each(function(idx){
						var elem = $(this);
						if(typeof elem.attr("data-oldWith") !== "undefined")
							elem.width(elem.attr("data-oldWith"));
					});
				}
				evt.preventDefault();
				this.blur();
			});

            $(document).ready(function(){
                CMEditor.getInstance("modelgeneratingscript").on("postPerformSaveDoc", function(){
                    refreshScriptList(); //in case the script was renamed
                });

                CMEditor.getInstance("scriptinterpretingdsl").on("postPerformSaveDoc", function(){
                    refreshDSLList(); //in case the dsl was renamed
                });
            });
		</script>
		&nbsp;
	</body>
</html>
