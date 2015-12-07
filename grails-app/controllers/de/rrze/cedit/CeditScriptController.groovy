package de.rrze.cedit

import static org.springframework.http.HttpStatus.*
import grails.converters.JSON

class CeditScriptController {

    static allowedMethods = [cmeditor_save: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CeditScript.list(params), model:[ceditScriptInstanceCount: CeditScript.count()]
    }

    def show(CeditScript ceditScriptInstance) {
        respond ceditScriptInstance
    }

    def manage(CeditScript ceditScriptInstance) {
        if(ceditScriptInstance == null)
            render(view: "manage")
        else
            respond ceditScriptInstance
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'ceditScript.label', default: 'CeditScript'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def cmeditor_open(Integer id){
        def instance = CeditScript.findById(id)

        if(instance == null){
            render ([status: "error", msg: "No such instance"] as JSON)
            return
        }

        render ([status:"success", result: instance] as JSON)
    }

    def cmeditor_list(){
        def list = CeditScript.findAll().collect({
            [id:it.id, label:it.label]
        })

        render ([status:"success", result: list] as JSON)
    }

    def cmeditor_save(Integer id){
        if(id == null){
            def instance = new CeditScript(params)
            instance.save(flush:true)
            render ([status:"success", msg: "file was created and saved", newId: instance.id] as JSON)
            return
        }

        def instance = CeditScript.findById(id)

        if(instance == null){
            render ([status: "error", msg: "Invalid script id provided"] as JSON)
            return
        }

        instance.content = params.content
        instance.label = params.label

        instance.save(flush:true)

        render ([status:"success"] as JSON)
    }

    def cmeditor_delete(Integer id){
        def instance = CeditScript.findById(id)

        if(instance == null){
            render ([status: "error", msg: "Invalid script id provided"] as JSON)
            return
        }

        try {
            instance.delete(flush:true)
        }catch(org.springframework.dao.DataIntegrityViolationException e){
            render ([status: "error", msg: "This script is still referenced in a template and can't be deleted"] as JSON)
            return
        }

        render([status:"success"] as JSON)
    }
}
