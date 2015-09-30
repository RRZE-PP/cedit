package de.rrze.dynamictaglib


import org.apache.commons.lang.RandomStringUtils

import static org.springframework.http.HttpStatus.*
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ModelDisplayingTemplateController {

	static allowedMethods = [cmeditor_save: "POST"]

	def index(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		respond ModelDisplayingTemplate.list(params), model:[modelDisplayingTemplateInstanceCount: ModelDisplayingTemplate.count()]
	}

	def show(ModelDisplayingTemplate modelDisplayingTemplateInstance) {
		respond modelDisplayingTemplateInstance
	}

	def manage(ModelDisplayingTemplate modelDisplayingTemplateInstance) {
		if(session["csrf-token"] == null)
			session["csrf-token"] = RandomStringUtils.randomAlphanumeric(255)

		if(modelDisplayingTemplateInstance == null)
			render(view: "manage")
		else
			respond modelDisplayingTemplateInstance
	}

	def preview(ModelDisplayingTemplate modelDisplayingTemplateInstance) {
		if(session["csrf-token"] && session["csrf-token"] == params["csrf-token"]){
			respond modelDisplayingTemplateInstance
		}else{
			flash.message = "For security reasons, please visit the template management page first!"
			redirect action: "index", method: "GET"
		}
	}

	protected void notFound() {
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.not.found.message', args: [
					message(code: 'modelDisplayingTemplate.label', default: 'ModelDisplayingTemplate'),
					params.id
				])
				redirect action: "index", method: "GET"
			}
			'*'{ render status: NOT_FOUND }
		}
	}

	def cmeditor_open(Integer id){
		def instance = ModelDisplayingTemplate.findById(id)

		if(instance == null){
			render ([status: "error", msg: "No such instance"] as JSON)
			return
		}

		render ([status:"success", result: instance] as JSON)
	}

	def cmeditor_list(){
		def list = ModelDisplayingTemplate.findAll().collect({
			[id:it.id, label:it.label]
		})

		render ([status:"success", result: list] as JSON)
	}

	def cmeditor_save(Integer id){
		if(id == null){
			def instance = new ModelDisplayingTemplate(params)
			instance.save(flush:true)
			render ([status:"success", msg: "file was created and saved", newId: instance.id] as JSON)
			return
		}

		def instance = ModelDisplayingTemplate.findById(id)
		def defaultScript = "defaultScript.id" in params ? ModelGeneratingScript.findById(params."defaultScript.id") : null

		if(instance == null){
			render ([status: "error", msg: "Invalid template id provided"] as JSON)
			return
		}

		if("defaultScript.id" in params && params."defaultScript.id" != null && defaultScript == null){
			render ([status: "error", msg: "Invalid default script provided"] as JSON)
			return
		}

		instance.content = params.content
		instance.label = params.label
		instance.defaultScript = defaultScript

		instance.save(flush:true)

		render ([status:"success"] as JSON)
	}

	def cmeditor_delete(Integer id){
		def instance = ModelDisplayingTemplate.findById(id)

		if(instance == null){
			render ([status: "error", msg: "Invalid template id provided"] as JSON)
			return
		}

		instance.delete(flush:true)

		render([status:"success"] as JSON)
	}
}
