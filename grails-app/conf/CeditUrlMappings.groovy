class CeditUrlMappings {

	static mappings = {
		"/$controller/$action?/$id?(.$format)?"{
			constraints {
				// apply constraints here
			}
		}
		"/" (view:"/index")
		"/demo" (view:"/demo")
	}
}
