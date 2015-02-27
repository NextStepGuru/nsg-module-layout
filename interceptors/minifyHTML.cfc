component {

	public void function preRender(required any event,required any interceptData) {
		var myOutput = arguments.interceptData.renderedContent;
		var nsgLayout = getSetting( name="nsgLayout", fwSetting=false, defaultValue={} )

		if( !event.isAjax() && structKeyExists(nsgLayout,'compressHTMLPages') && nsgLayout['compressHTMLPages'] ){
			myOutput = reReplace(myOutput,'[^[:print:]]','','all');
			myOutput = reReplace(myOutput,'<!--(?!<!)[^\[>].*?-->','','all');
			myOutput = reReplace(myoutput,"\>[\t\n\r\f ]+\<",'><','all');
		}

		arguments.interceptData.renderedContent = trim(myOutput);
	}
}
