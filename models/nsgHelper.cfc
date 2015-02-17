component name="nsgHelper" {
	property name="coldbox" inject="coldbox:requestService";
	property name="html" inject="id:HTMLHelper@coldbox";

	// event announcements, funky for whitespace reasons
	public function outputInterceptData(required state,struct data=structNew()) {
		var data = "";

		return evaluate("#arguments.state#()");
	}

	public function isPathActive(required string path="",required string class="active"){

		if( path eq '/' && cgi.path_info eq '/' ){
			return 'active';
		}else if( cgi.path_info neq '/'){
			return ( cgi.path_info eq left(arguments.path & '/',len(cgi.path_info)) ? class : '' );
		}else{
			return "";
		}
	}

	public string function layoutHeadTag(){
		var buffer	= createObject("java","java.lang.StringBuffer").init("");
		var prc = coldbox.getContext().getCollection(private=true);

		if(structKeyExists(prc.page,'tags') && structKeyExists(prc.page.tags,'head')){
			for(var i=1;i<=arrayLen(prc.page.tags.head);i++){
				buffer.append(' ' & trim(prc.page.tags.head[i]));
			}
		}

		return buffer.toString();
	}

	public string function layoutHTMLTag(){
		var buffer	= createObject("java","java.lang.StringBuffer").init("");
		var prc = coldbox.getContext().getCollection(private=true);

		if(structKeyExists(prc.page,'tags') && structKeyExists(prc.page.tags,'html')){
			for(var i=1;i<=arrayLen(prc.page.tags.html);i++){
				buffer.append(' ' & trim(prc.page.tags.html[i]));
			}
		}

		return buffer.toString();
	}

	public string function layoutBodyTag(){
		var buffer	= createObject("java","java.lang.StringBuffer").init("");
		var prc = coldbox.getContext().getCollection(private=true);

		if(structKeyExists(prc.page,'tags') && structKeyExists(prc.page.tags,'body')){
			for(var i=1;i<=arrayLen(prc.page.tags.body);i++){
				buffer.append(' ' & trim(prc.page.tags.body[i]));
			}
		}

		return buffer.toString();
	}

	public string function layoutHeadScripts() {
		var buffer	= createObject("java","java.lang.StringBuffer").init("");
		var prc = coldbox.getContext().getCollection(private=true);

		var ifComments = structNew();

		// output the original scripts
		for(var i=1;i<=arrayLen(prc.page.scripts);i++){
			structDelete(prc.page.scripts[i],'tag')
			if(!structKeyExists(prc.page.scripts[i],'ifComment')){
				buffer.append(html.script(argumentCollection=prc.page.scripts[i]));
			}else{
				var tName = reReplace(prc.page.scripts[i]['ifComment'],'[[:punct:][:space:]]','','all');
				if( !structKeyExists(ifComments,tName) ){
					ifComments[tName] = {'name':prc.page.scripts[i]['ifComment'],'data':[]};
				}
				arrayAppend(ifComments[tName]['data'],prc.page.scripts[i]);
			}
		}

		/*
			output if based script comments.
		*/
		var temp = "";
		var tempOutput = false;
		for(var key IN ifComments){
			if(temp neq ifComments[key]['name']){
				temp=ifComments[key]['name'];
				tempOutput=true;
				buffer.append('<!--[if #temp#]>');
			}

			for(var i=1;i<=arrayLen(ifComments[key]['data']);i++){
				structDelete(ifComments[key]['data'][i],'tag');
				structDelete(ifComments[key]['data'][i],'ifComment');
				buffer.append(html.script(argumentCollection=ifComments[key]['data'][i]));
			}

			if(tempOutput){
				tempOutput=false;
				buffer.append('<![endif]-->');
			}
		}

		return buffer.toString();
	}

	public string function layoutHeadStyles() {
		var buffer	= createObject("java","java.lang.StringBuffer").init("");
		var prc = coldbox.getContext().getCollection(private=true);

		for(var i=1;i<=arrayLen(prc.page.styles);i++){
			structDelete(prc.page.styles[i],'tag')
			prc.page.styles[i]['noBaseURL'] = true;
			buffer.append(html.link(argumentCollection=prc.page.styles[i]));
		}

		return buffer.toString();
	}

	public string function layoutHeadMeta() {
		var buffer	= createObject("java","java.lang.StringBuffer").init("");
		var prc = coldbox.getContext().getCollection(private=true);

		for(var i=1;i<=arrayLen(prc.page.head);i++){
			if(prc.page.head[i]['tag'] == 'title'){
				buffer.append(html.title(argumentCollection=prc.page.head[i]));
			}else{
				// I couldn't use HTML Helper as it doesn't currently support OpenGraph
				// so i extended the htmlHelper and added metaCustom
				buffer.append(html.metaCustom(target=prc.page.head[i]));
			}
		}

		return buffer.toString();
	}

	public string function layoutBodyBeforeEnd(){
		var buffer	= createObject("java","java.lang.StringBuffer").init("");
		var prc = coldbox.getContext().getCollection(private=true);

		for(var i=1;i<=arrayLen(prc.page.body.end);i++){
			buffer.append(prc.page.body.end[i]);
		}

		return buffer.toString();
	}

	public string function layoutBodyScripts(){
		var buffer	= createObject("java","java.lang.StringBuffer").init("");
		var prc = coldbox.getContext().getCollection(private=true);

		for(var i=1;i<=arrayLen(prc.page.body.scripts);i++){
			structDelete(prc.page.body.scripts[i],'tag')
			buffer.append(html.script(argumentCollection=prc.page.body.scripts[i]));
		}

		return buffer.toString();
	}
}