component {

	property name="underscoreService" inject="underscoreService@layout";

	public any function sortAndGroupFiles(required array data){
		var remoteFiles 	= [];
		var returnFiles 	= [];
		var localFiles 		= [];
		var dependentFiles 	= [];
		var dependencies	= [];
		var localGroup 		= [];
		var localDependency = arrayNew();
		var srcOrHREF 		= ( structKeyExists(data.first(),'src') ? 'src' : 'href' );
		var jsOrCSS 		= ( structKeyExists(data.first(),'src') ? 'js' : 'css' );

		data.each(function(item,position){
			if(!structKeyExists(item,'name')){
				item['name'] = listLast(item[srcOrHREF],'/');
			}
			if(!structKeyExists(item,'dependency')){
				item['dependency'] = "";
			}else{
				localDependency.append(item['dependency']);
			}

			if( left(item[srcOrHREF],4) eq 'http' ){
				item['content'] = '';
			}else if( !structKeyExists(item,'compress') || item['compress'] ){
				var tFile = fileRead(expandPath('./') & item[srcOrHREF]);
				for(var key IN item){
					tFile = replace(tFile,'{{#key#}}',item[key],'all');
				}
				item['content'] = tFile;
			}else{
				item['content'] = '';
			}

			// split local & remote files;
			if( left(item[srcOrHREF],4) eq 'http' ){
				localGroup.append([item]);
			}else if( len(item['dependency']) ){
				localFiles.append(item);
			}else{
				dependencies.append(item['name']);
				dependentFiles.append(item);
			}
		});
		localGroup.append(dependentFiles);

		var sorter = underscoreService.init();
		localFiles = sorter.sortBy(localFiles, function (obj) {
			return obj.dependency;
		});
		var breakPoint = 0;
		do{
			for(var i=1;i<=arrayLen(localFiles);i++){
				if( dependencies.find(localFiles[i]['dependency']) ){
					dependencies.append(localFiles[i]['name']);
					localGroup.append([localFiles[i]]);
					localFiles.deleteAt(i);
					break;
				}
			}
			breakPoint++;
			if(breakPoint gte 100){
				throw('Unable to find a dependency');
			};

		}while( localFiles.len() );


		for(var i=1;i<=arrayLen(localGroup);i++){
			var stringBuffer = createObject('java','java.lang.StringBuffer').init('');
			for(var f=1;f<=arrayLen(localGroup[i]);f++){
				if( left(localGroup[i][f][srcOrHREF],4) eq 'http' ){
					returnFiles.append(localGroup[i][f]);
				}else if( structKeyExists(localGroup[i][f],'compress') && localGroup[i][f]['compress'] == false ){
					returnFiles.append(localGroup[i][f]);
				}else{
					stringBuffer.append(localGroup[i][f]['content']);
				}
			}
			if( len(stringBuffer.toString()) ){
				var myFile = hash(stringBuffer.toString()) & '.' & jsOrCSS;
				if(!directoryExists(expandPath('./assets/cache/'))){
					directoryCreate(expandPath('./assets/cache/'));
				}
				fileWrite(expandPath('./assets/cache/') & myFile, stringBuffer.toString());
				returnFiles.append({'tag':'script','#srcOrHREF#':'/assets/cache/' & myFile});
			}
		}

		return returnFiles;
	}

	public void function preLayoutRender(event,interceptData,buffer){
		var prc = event.getCollection(private=true);
		var nsgLayout = getSetting( name="nsgLayout", fwSetting=false, defaultValue={} )

		if( nsgLayout.keyExists('combineJSFiles') && nsgLayout['combineJSFiles'] ){
			var cacheFileName = hash(prc.page.body.scripts.toString());
			if( event.valueExists('ormreload') || !structKeyExists(application,cacheFileName) ){

				application[cacheFileName] = sortAndGroupFiles(prc.page.body.scripts);
				prc.page.body.scripts = application[cacheFileName];

			}else{

				prc.page.body.scripts = application[cacheFileName];
			}
		}

		if( nsgLayout.keyExists('combineCSSFiles') && nsgLayout['combineCSSFiles'] ){
			var cacheFileName = hash(prc.page.styles.toString());
			if( event.valueExists('ormreload') || !fileExists(expandPath('./assets/cache/') & cacheFileName & '.css') ){

				application[cacheFileName] = sortAndGroupFiles(prc.page.styles);
				prc.page.styles = application[cacheFileName];

			}else{

				prc.page.styles = application[cacheFileName];
			}
		}
	}

}