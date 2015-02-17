<cfoutput>
<!DOCTYPE html>
<html#nsg.outputInterceptData('layoutHTMLTag')#>
	<head#nsg.outputInterceptData('layoutHeadTag')#>
		#nsg.outputInterceptData('layoutHeadMeta')#
		#nsg.outputInterceptData('layoutHeadStyles')#
		#nsg.outputInterceptData('layoutHeadScripts')#
	</head>
	<body#nsg.outputInterceptData('layoutBodyTag')#>
		#renderView(view="includes/header",module="nsg-module-layout")#
		#renderView(view="includes/navbar",module="nsg-module-layout")#
		<div class="content">
			<div class="container">
				#renderView()#
			</div>
		</div>
		#renderView(view="includes/footer",module="nsg-module-layout")#
		#nsg.outputInterceptData('layoutBodyScripts')#
		#nsg.outputInterceptData('layoutBodyBeforeEnd')#
	</body>
</html>
</cfoutput>