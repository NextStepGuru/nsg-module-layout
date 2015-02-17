component {

	property name="html" inject="id:HTMLHelper@coldbox";

	public void function preProcess(event,interceptData,buffer) {
		var prc = event.getCollection(private=true);

		if( !event.isAjax() ){

			event.setLayout( name='home', module='nsg-module-layout' )

			var defaults = duplicate(getSetting('pageDefaults'));

			if(!structKeyExists(prc,'page')){
				prc['page'] = defaults;
			}else{
				var old = prc['page'];
				prc['page'] = defaults;


				for(var key IN old){
					if( isArray(old[key]) ){

						for(var i=1;i<=arrayLen(old[key]);i++){
							arrayAppend(prc.page[key],old[key][i]);
						}
					}else if(isStruct(old[key])){
						for(var subKey in old[key]){
							if( isArray(old[key][subKey]) ){
								for(var i=1;i<=arrayLen(old[key][subKey]);i++){
									arrayAppend(prc.page[key][subKey],old[key][subKey][i]);
								}
							}
						}
					}
				}
			}

		if( len(event.getCurrentModule()) ){
			arrayAppend(prc.page.styles,{'tag':'link','href':event.getModuleRoot(event.getCurrentModule()) & "/assets/css/#event.getCurrentModule()#-module.css"});

			arrayAppend(prc.page.body.scripts,{'tag':'script','src':event.getModuleRoot(event.getCurrentModule()) & "/assets/js/#event.getCurrentModule()#-module.js",'async':true});
		}

		}else if( event.isAjax() ){
			event.noLayout();
		}

		announceInterception( state='addPageBeforeEnd',
			          interceptData={'html':renderView(view="includes/tracking",module="nsg-module-layout")});
	}

	public void function handleError403(event,interceptData,buffer) {

		buffer.clear();
		header statuscode="403" statustext="Forbidden";
		event.setView(view='errors/e403',module="nsg-module-layout");
	}

	public void function handleError404(event,interceptData,buffer) {

		buffer.clear();
		header statuscode="404" statustext="File not Found";
		event.setView(view='errors/e404',module="nsg-module-layout");
	}

	public void function handleError500(event,interceptData,buffer) {

		buffer.clear();
		header statuscode="500" statustext="Internal Server Error";
		event.setView(view='errors/e500',module="nsg-module-layout");
	}

	public void function addHeadTag(event,interceptData){
		var prc = event.getCollection(private=true);
		if( !event.isAjax() ){
			if(!structKeyExists(prc.page,'tags')){
				prc.page['tags'] = structNew();
			}
			if(!structKeyExists(prc.page.tags,'head')){
				prc.page.tags['head'] = arrayNew();
			}

			arrayAppend(prc.page.tags.head,trim(interceptData['html']));
		}
	}

	public void function addBodyTag(event,interceptData){
		var prc = event.getCollection(private=true);
		if( !event.isAjax() ){
			if(!structKeyExists(prc.page,'tags')){
				prc.page['tags'] = structNew();
			}
			if(!structKeyExists(prc.page.tags,'body')){
				prc.page.tags['body'] = arrayNew();
			}

			arrayAppend(prc.page.tags.body,trim(interceptData['html']));
		}
	}

	public void function addHTMLTag(event,interceptData){
		var prc = event.getCollection(private=true);
		if( !event.isAjax() ){
			if(!structKeyExists(prc.page,'tags')){
				prc.page['tags'] = structNew();
			}
			if(!structKeyExists(prc.page.tags,'html')){
				prc.page.tags['html'] = arrayNew();
			}

			arrayAppend(prc.page.tags.html,trim(interceptData['html']));
		}
	}

	public void function addPageBeforeEnd(required event,required interceptData){
		var prc = event.getCollection(private=true);
		if( !event.isAjax() ){

			if(!structKeyExists(prc,'page')){
				prc['page'] = structNew();
			}
			if(!structKeyExists(prc.page,'body')){
				prc.page['body'] = structNew();
			}
			if(!structKeyExists(prc.page.body,'end')){
				prc.page.body['end'] = arrayNew();
			}

			arrayAppend(prc.page.body.end,interceptData['html']);
		}
	}

	public void function addPageHeadStyle(required event,required interceptData){
		var prc = event.getCollection(private=true);
		if( !event.isAjax() ){

			if(!structKeyExists(prc,'page')){
				prc['page'] = structNew();
			}
			if(!structKeyExists(prc.page,'styles')){
				prc.page['styles'] = arrayNew();
			}

			arrayAppend(prc.page.styles,interceptData);
		}
	}

	public void function addPageHeadScript(required event,required interceptData){
		var prc = event.getCollection(private=true);
		if( !event.isAjax() ){

			arrayAppend(prc.page.head.scripts,interceptData);
		}
	}

	public void function addPageBodyScript(required event,required interceptData){
		var prc = event.getCollection(private=true);
		if( !event.isAjax() ){

			arrayAppend(prc.page.body.scripts,interceptData);
		}
	}

	public void function addPageHead(required event,required interceptData){
		var prc = event.getCollection(private=true);
		if( !event.isAjax() ){

			if(structKeyExists(interceptData,'title') && !structKeyExists(interceptData,'tag')){
				interceptData['tag']='title';
				interceptData['content']=interceptData['title'];
				structDelete(interceptData,'title');
			}

			for(var i=1;i<=arrayLen(prc.page.head);i++){
				if( structKeyExists(prc.page.head[i],'tag') && structKeyExists(interceptData,'tag') && interceptData['tag']==prc.page.head[i]['tag']){
					for(var key IN interceptData){
						prc.page.head[i][key] = interceptData[key];
					}
				}
			}

		}
	}
}