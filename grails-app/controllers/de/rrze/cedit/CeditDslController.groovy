package de.rrze.cedit

import static org.springframework.http.HttpStatus.*
import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CeditDslController {

    static allowedMethods = [cmeditor_save: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CeditDsl.list(params), model:[ceditDslCount: CeditDsl.count()]
    }

    def show(CeditDsl ceditDslInstance) {
        respond ceditDslInstance
    }

    def manage(CeditDsl ceditDslInstance) {
        if(ceditDslInstance == null)
            render(view: "manage")
        else
            respond ceditDslInstance
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'ceditDsl.label', default: 'ceditdsl'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def cmeditor_open(Integer id){
        def instance = CeditDsl.findById(id)

        if(instance == null){
            render ([status: "error", msg: "No such instance"] as JSON)
            return
        }

        render ([status:"success", result: instance] as JSON)
    }

    def cmeditor_list(){
        def list = CeditDsl.findAll().collect({
            [id:it.id, label:it.label]
        })

        render ([status:"success", result: list] as JSON)
    }

    def cmeditor_save(Integer id){
        if(id == null){
            def instance = new CeditDsl(params)
            instance.save(flush:true)
            render ([status:"success", msg: "file was created and saved", newId: instance.id] as JSON)
            return
        }

        def instance = CeditDsl.findById(id)

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
        def instance = CeditDsl.findById(id)

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
