package de.rrze.dynamictaglib



import static org.springframework.http.HttpStatus.*
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ScriptInterpretingDSLController {

    static allowedMethods = [cmeditor_save: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ScriptInterpretingDSL.list(params), model:[scriptInterpretingDSLCount: ScriptInterpretingDSL.count()]
    }

    def show(ScriptInterpretingDSL scriptInterpretingDSLInstance) {
        respond scriptInterpretingDSLInstance
    }

    def manage(ScriptInterpretingDSL scriptInterpretingDSLInstance) {
        if(scriptInterpretingDSLInstance == null)
            render(view: "manage")
        else
            respond scriptInterpretingDSLInstance
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'scriptInterpretingDSL.label', default: 'ScriptInterpretingDSL'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def cmeditor_open(Integer id){
        def instance = ScriptInterpretingDSL.findById(id)

        if(instance == null){
            render ([status: "error", msg: "No such instance"] as JSON)
            return
        }

        render ([status:"success", result: instance] as JSON)
    }

    def cmeditor_list(){
        def list = ScriptInterpretingDSL.findAll().collect({
            [id:it.id, label:it.label]
        })

        render ([status:"success", result: list] as JSON)
    }

    def cmeditor_save(Integer id){
        if(id == null){
            def instance = new ScriptInterpretingDSL(params)
            instance.save(flush:true)
            render ([status:"success", msg: "file was created and saved", newId: instance.id] as JSON)
            return
        }

        def instance = ScriptInterpretingDSL.findById(id)

        if(instance == null){
            render ([status: "error", msg: "Invalid dsl id provided"] as JSON)
            return
        }

        instance.code = params.code
        instance.label = params.label
        instance.closureName = params.closureName

        instance.save(flush:true)

        render ([status:"success"] as JSON)
    }

    def cmeditor_delete(Integer id){
        def instance = ScriptInterpretingDSL.findById(id)

        if(instance == null){
            render ([status: "error", msg: "Invalid dsl id provided"] as JSON)
            return
        }

        try {
            instance.delete(flush:true)
        }catch(org.springframework.dao.DataIntegrityViolationException e){
            render ([status: "error", msg: "This dsl is still referenced in a script and can't be deleted"] as JSON)
            return
        }

        render([status:"success"] as JSON)
    }
}
