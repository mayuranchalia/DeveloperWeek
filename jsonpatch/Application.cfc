<!---
<cffunction name="onRESTRequest" returntype="any" output="true"> 
 	
<cfargument type="string" name="cfcname" required=true> 
 	<cfargument type="string" name="method" required=true> 
 	<cfargument type="struct" name="args" required=true> 
 	<cflog text="onRESTRequest() Before"> 
 	      
   	<cfinvoke component = "#cfcname#" method = "#method#" argumentCollection  = "#args#" returnVariable = "resultval"> 
 	
 	<cflog text="onRESTRequest() After"> 
 	<cfreturn "#resultval#"> 
</cffunction>
--->