<cfcomponent restpath="patchillustration" > 
     <cffunction name="getEmployee" returntype="student" restpath="studentdetails"  
     		httpmethod="GET" description="Retrieve Student" produces="application/json">              
        <cfset myobj = CreateObject("component", "student")>	 
        <cfset myobj.name = "Joe">
        <cfset myobj.age = 24>
		<cfset myobj.college = "Stanford University">    
        <cfset myobj.course = "Statistics">
		<cfset myobj.semester = "2nd semester">		
		<!---<cfset studentdetils>--->
        <cfreturn myobj>           
    </cffunction>    
	
	 <cffunction name="patchEmployee" returntype="student" restpath="studentdetails"  
	 	httpmethod="PATCH" description="Patche Student" produces="application/json"> 
        <cfargument name="patchedobject" type="student" required="true"> 
        <cfreturn patchedobject>           
    </cffunction>    
	
</cfcomponent>