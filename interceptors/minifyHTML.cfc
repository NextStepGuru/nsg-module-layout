component {

	public void function preRender(required any event,required any interceptData) {
		var myOutput = arguments.interceptData.renderedContent;

		if( !event.isAjax() ){
			myOutput = reReplace(myOutput,'[^[:print:]]','','all');
			myOutput = reReplace(myOutput,'<!--(?!<!)[^\[>].*?-->','','all');
			myOutput = reReplace(myoutput,"\>[\t\n\r\f ]+\<",'><','all');
		}
		arguments.interceptData.renderedContent = trim(myOutput);
	}
}
