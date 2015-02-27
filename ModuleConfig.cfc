component {

	// Module Properties
	this.title 				= "NSG's Layout Module";
	this.author 			= "Jeremy R DeYoung";
	this.webURL 			= "http://www.nextstep.guru";
	this.description 		= "This is the default configuration for nsg's layout.";
	this.version			= "1.0.5";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "layout";
	// Model Namespace
	this.modelNamespace		= "layout";
	// CF Mapping
	this.cfmapping			= "layout";
	// Module Dependencies
	this.dependencies 		= [];

	function configure(){

		// parent settings
		parentSettings = {

		};

		// module settings - stored in modules.name.settings
		settings = {
		};

		// Layout Settings
		layoutSettings = {
		};

		// datasources
		datasources = {

		};

		// SES Routes
		routes = [
			// Module Entry Point
			{pattern="/", handler="home",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];

		// Custom Declared Points
		interceptorSettings = {
			customInterceptionPoints = "handleError403,handleError404,handleError500," &
				"addPageHead,addPageHeadStyle,addBodyTag,addHTMLTag,addHeadTag,addPageHeadScript,addPageBodyScript,addPageBeforeEnd"
		};

		// Custom Declared Interceptors
		interceptors = [
			{name="layout@layout",class="#moduleMapping#.interceptors.layout"},
			{name="menu@layout",class="#moduleMapping#.interceptors.menu"},
			{name="compress@layout",class="#moduleMapping#.interceptors.compress"},
			{name="minifyHTML@layout",class="#moduleMapping#.interceptors.minifyHTML"}
		];

		// Binder Mappings
		binder.mapDirectory( "#moduleMapping#.models" );
		// replace the current htmlHelper built-into Coldbox with my new changes
		binder.map("HTMLHelper@coldbox").to("#moduleMapping#.models.HTMLHelper");
		binder.map("Renderer@coldbox").to("#moduleMapping#.models.renderer");
		binder.map("nsgHelper@layout").to("#moduleMapping#.models.nsgHelper");

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){

	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

}