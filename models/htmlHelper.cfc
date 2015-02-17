component name="htmlHelper" extends="coldbox.system.core.dynamic.HTMLHelper" {

	public function metaCustom(required any target, required boolean sendToHeader=false){
		var x 		= 1;
		var buffer	= createObject("java","java.lang.StringBuffer").init("");
		var tmpType = "";

		buffer.append('<#lcase(arguments.target['tag'])# ');

		flattenAttributes(target=arguments.target,excludes="tag",buffer=buffer);

		buffer.append('>');

		//Load it
		if( arguments.sendToHeader AND len(buffer.toString())){
			$htmlhead(buffer.toString());
		}
		else{
			return buffer.toString();
		}
	}

	public function editorField(){
		if(!structKeyExists(arguments,'sendToHeader')){
			arguments['sendToHeader']=false;
		}

		if( isNull(arguments.value) || arguments.value == 'null' ){
			arguments.value="";
		}

		var buffer	= createObject("java","java.lang.StringBuffer").init("");

		buffer.append('<div class="form-group">');

			buffer.append('<label for="' & arguments.name & '" class="col-sm-2 control-label">' & arguments.label & ": </label>");

			buffer.append('<div class="col-sm-10"> ');

				switch(arguments.type){
					case "select":
						var queryService = new query(sql="SELECT #arguments.primaryKey# AS ID,#arguments.display# AS display FROM #arguments.table#;").execute().getResult();
						buffer.append('<select class="form-control" type="number" ');
							flattenAttributes(target=arguments,excludes="tag,type,label,value",buffer=buffer);
							buffer.append('>');
							buffer.append('<option value="0">Not Selected / N/A</option>' );
							for(var i=1;i<=queryService.recordCount;i++){
								buffer.append('<option value="' & queryService['id'][i] & '"' & ( arguments.value == queryService['id'][i] ? ' SELECTED="SELECTED"' : "") & '>' & queryService['display'][i] & "</option>" );
							}
						buffer.append('</select>');
						break;

					case "timestamp":
						buffer.append('<input class="form-control" type="datetime-local" ');
							flattenAttributes(target=arguments,excludes="tag,type,label,value",buffer=buffer);
							buffer.append(' value="#dateFormat(arguments.value,'yyyy-mm-dd')#T#timeFormat(arguments.value,'HH:MM')#" ');
						buffer.append('>');
						break;

					case "textarea":
						buffer.append('<textarea class="form-control" ');
							flattenAttributes(target=arguments,excludes="tag,type,label,value",buffer=buffer);
							buffer.append('>');
							buffer.append(arguments.value);
						buffer.append('</textarea>');
						break;

					case "htmleditor":
						buffer.append('<textarea class="form-control html-editor" style="height:600px;" ');
							flattenAttributes(target=arguments,excludes="tag,type,label,value",buffer=buffer);
							buffer.append('>');
							buffer.append(arguments.value);
						buffer.append('</textarea>');
						break;

					case "yesno":
						buffer.append('<select class="form-control" type="number" ');
							flattenAttributes(target=arguments,excludes="tag,type,label,value",buffer=buffer);
							buffer.append('>');
							buffer.append('<option value="0">No</option>');
							if( arguments.value ){
								buffer.append('<option value="1" SELECTED="SELECTED">Yes</option>');
							}else{
								buffer.append('<option value="1">Yes</option>');
							}
						buffer.append('</select>');
						break;

					case "integer":
					case "float":
					case "number":
						buffer.append('<input class="form-control" type="number" ');
							flattenAttributes(target=arguments,excludes="tag,type,label",buffer=buffer);
						buffer.append('>');

						break;

					case "text":
					case "string":
					case "input":
						buffer.append('<input class="form-control" ');
							flattenAttributes(target=arguments,excludes="tag,type,label",buffer=buffer);
						buffer.append('>');

						break;

					case "password":
						buffer.append('<input type="password" class="form-control" ');
							flattenAttributes(target=arguments,excludes="tag,type,label,value",buffer=buffer);
						buffer.append('>');

						break;

					case "hint":
						buffer.append('<span');
							flattenAttributes(target=arguments,excludes="tag,type,label,value",buffer=buffer);
						buffer.append('>');
							buffer.append(arguments.value);
						buffer.append('</span>');

						break;

					default:
						buffer.append(arguments.type);
				}

			buffer.append('</div>');

		buffer.append('</div>');


		//Load it
		if( arguments.sendToHeader AND len(buffer.toString())){
			$htmlhead(buffer.toString());
		}
		else{
			return buffer.toString();
		}
	}
}