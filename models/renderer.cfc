component name="renderer" extends="coldbox.system.web.Renderer" {

	// i'm injecting a private variable called RW that is accessible in any view.
	// this allows me to create all kinds of custom functions
	property name="nsg" inject="id:nsgHelper@layout";

}