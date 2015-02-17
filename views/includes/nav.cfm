<cfoutput>
	<ul class="nav navbar-nav">
		<li class="#nsg.isPathActive('/')# compact-item"><a href="/"><i class="fa fa-home"></i> Home</a></li>
	</ul>
	<ul class="nav navbar-nav pull-right">
		<cfif isUserLoggedIn()>
			<li class="#nsg.isPathActive('/logout')# compact-item"><a href="/security/logout"><i class="fa fa-sign-out"></i> Logout</a>
		<cfelse>
			<li class="#nsg.isPathActive('/login')# dropdown">
				<a href="##" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-sign-in"></i> Login <span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu">
					<li><a href="/security/signup">Sign-up for an Account</a></li>
					<li><a href="/security/login">Login with a Password</a></li>
					<li class="divider"></li>
					<li><a href="/security/google"><i class="fa fa-google-plus"></i> Google Social Login</a></li>
					<li><a href="/security/facebook"><i class="fa fa-facebook"></i> Facebook Social Login</a></li>
					<li><a href="/security/twitter"><i class="fa fa-twitter"></i> Twitter Social Login</a></li>
					<li><a href="/security/linkedin"><i class="fa fa-linkedin"></i> LinkedIn Social Login</a></li>
					<li><a href="/security/trello"><i class="fa fa-trello"></i> Trello Social Login</a></li>
					<li><a href="/security/evernote"><i class="fa fa-evernote"></i> Evernote Social Login</a></li>
				</ul>
			</li>
		</cfif>
	</ul>


</cfoutput>