package de.rrze.dynamictaglib



import static org.springframework.http.HttpStatus.*
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ModelGeneratingScriptController {

    static allowedMethods = [cmeditor_save: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ModelGeneratingScript.list(params), model:[modelGeneratingScriptInstanceCount: ModelGeneratingScript.count()]
    }

    def show(ModelGeneratingScript modelGeneratingScriptInstance) {
        respond modelGeneratingScriptInstance
    }

    def manage(ModelGeneratingScript modelGeneratingScriptInstance) {
        if(modelGeneratingScriptInstance == null)
            render(view: "manage")
        else
            respond modelGeneratingScriptInstance
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'modelGeneratingScript.label', default: 'ModelGeneratingScript'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def cmeditor_open(Integer id){
        def instance = ModelGeneratingScript.findById(id)

        if(instance == null){
            render ([status: "error", msg: "No such instance"] as JSON)
            return
        }

        render ([status:"success", result: instance] as JSON)
    }

    def cmeditor_list(){
        def list = ModelGeneratingScript.findAll().collect({
            [id:it.id, label:it.label]
        })

        render ([status:"success", result: list] as JSON)
    }

    def cmeditor_save(Integer id){
        if(id == null){
            def instance = new ModelGeneratingScript(params)
            instance.save(flush:true)
            render ([status:"success", msg: "file was created and saved", newId: instance.id] as JSON)
            return
        }

        def instance = ModelGeneratingScript.findById(id)

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
        def instance = ModelGeneratingScript.findById(id)

        if(instance == null){
            render ([status: "error", msg: "Invalid script id provided"] as JSON)
            return
        }

        instance.delete(flush:true)

        render([status:"success"] as JSON)
    }
}
