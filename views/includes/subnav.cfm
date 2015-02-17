<cfoutput>
	<ul class="subnav subnavbar-nav">
		<li>Contact Us Today! (615) 410-0684</li>
		<li class="compact-item"><a href="/about">About</a></li>
		<li class="compact-item"><a href="/contact">Contact</a></li>
		<cfif isUserLoggedIn()>
			<li class="compact-item"><a href="/security/logout">Logout</a>
		<cfelse>
			<li class="compact-item"><a href="/security/login">Login</a>
		</cfif>
	</ul>
</cfoutput>