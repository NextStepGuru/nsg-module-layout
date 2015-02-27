component {

	public void function preLayoutRender(event,interceptData,buffer){
		var prc = event.getCollection(private=true);
		var nsgMenu = getSetting( name='nsgMenu', fwSetting=false, defaultValue=arrayNew() );
		prc['nsgMenu'] = structNew();

		var subItems = arrayNew();
		for(var i=1;i<=arrayLen(nsgMenu);i++){
			var thisMenu = nsgMenu[i]['menu'];
			if(!structKeyExists(prc['nsgMenu'],thisMenu)){
				prc['nsgMenu'][thisMenu] = structNew();
			}

			var thisItem = nsgMenu[i];
			if(!structKeyExists(thisItem,'subid') || thisItem['subid'] == ''){
				if( !structKeyExists(thisItem,'isUserLoggedIn') || thisItem['isUserLoggedIn'] == isUserLoggedIn() ){
					prc['nsgMenu'][thisMenu][thisItem['id']] = {
						"subid" 	= ( structKeyExists(thisItem,'subid') ? thisItem['subid'] : ''),
						"id" 		= ( structKeyExists(thisItem,'id') ? thisItem['id'] : ''),
						"icon" 		= ( structKeyExists(thisItem,'icon') ? thisItem['icon'] : ''),
						"link" 		= ( structKeyExists(thisItem,'link') ? thisItem['link'] : ''),
						"title" 	= ( structKeyExists(thisItem,'title') ? thisItem['title'] : ''),
						"type" 		= ( structKeyExists(thisItem,'type') ? thisItem['type'] : 'link'),
						"class"		= ( structKeyExists(thisItem,'class') ? thisItem['class'] : 'compact-item'),
						"submenu"	= structNew()
					};
				}
			}else{
				subItems.append(thisItem);
			}
		}

		for(var i=1;i<=arrayLen(subItems);i++){
			var thisMenu = subItems[i]['menu'];
			var thisItem = subItems[i];
			var thisSubMenu = thisItem['subid'];

			if( !structKeyExists(thisItem,'isUserLoggedIn') || thisItem['isUserLoggedIn'] == isUserLoggedIn() ){
				prc['nsgMenu'][thisMenu][thisSubMenu]['submenu'][thisItem['id']] = {
					"id" 		= ( structKeyExists(thisItem,'id') ? thisItem['id'] : ''),
					"icon" 		= ( structKeyExists(thisItem,'icon') ? thisItem['icon'] : ''),
					"link" 		= ( structKeyExists(thisItem,'link') ? thisItem['link'] : ''),
					"title" 	= ( structKeyExists(thisItem,'title') ? thisItem['title'] : ''),
					"class"		= ( structKeyExists(thisItem,'class') ? thisItem['class'] : ''),
					"type" 		= ( structKeyExists(thisItem,'type') ? thisItem['type'] : 'link')
				};
			}
		}
	}
}