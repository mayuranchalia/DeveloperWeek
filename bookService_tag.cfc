<!---<cfcomponent rest="true" restpath="books" displayname="books">
	
	<cffunction name="test" access="remote" produces="text/plain" returntype="string" httpmethod="GET" >
		<cfreturn "testing">
	</cffunction>
	

<cffunction name="getBookDetails" access="remote" httpmethod="GET" returntype="any" restpath="{bookid}"  produces="application/xml,application/json">
			<cfargument name="bookid" required="true" restargsource="Path" type="string">
		
		<cftry>	
			<cfif not len(trim("#arguments.bookid#"))>
				<cfthrow errorcode="400" message="Bad Request1" type="400" detail="Bookid not provided" >	
			<cfelseif stringCheck("#arguments.bookid#")>
				<cfthrow errorcode="400" message="Bad Request2" type="400" detail="Bookid provided is not valid format">	
			<cfelse>
				<cfquery name="qBookDetails" datasource="cfbookclub">
					select b.bookid, a.firstname, a.lastname, a.authorid, b.title, b.bookimage, b.bookdescription, b.isspotlight, b.genre
					from books b, authors a
					where a.authorid = b.authorid
					and b.bookid = #arguments.bookid#
				</cfquery>

				<cfif not qBookDetails.recordcount>
					<cfthrow errorcode="404" message="Book not found" type="400" detail="A book with ID #arguments.bookid# was not found">	
				<cfelseif qBookDetails.recordcount gt 1>
					<cfthrow errorcode="400" message="Bad Request" type="400" detail="Multiple books were found with ID #arguments.bookid#">
				</cfif>
			</cfif>
			<cfdump var="#qBookDetails#" output="console" >
		<cfcatch type="Any">
			<cfthrow errorcode="400" message="Bad Request3" type="500" detail="#cfcatch.detail#">
		</cfcatch>		
		</cftry>
		<cfreturn qBookDetails> 			
	</cffunction>
	
	<cffunction name="getBooks" access="remote" httpmethod="GET" returntype="any" produces="application/xml,application/json">
		<cftry>	
				<cfquery name="qBookDetails" datasource="cfbookclub">
					select b.bookid, b.title, b.bookimage, b.bookdescription, b.isspotlight, b.genre
					from app.books b
				</cfquery>
				
				<cfif not qBookDetails.recordcount>
					<cfthrow errorcode="404" message="Book not found" type="400" detail="A book with ID #arguments.bookid# was not found">	
				<cfelseif qBookDetails.recordcount gt 1>
					<cfthrow errorcode="400" message="Bad Request" type="400" detail="Multiple books were found with ID #arguments.bookid#">
				</cfif>
		<cfcatch type="Any">
			<cfthrow errorcode="400" message="Bad Request" type="400" detail="#cfcatch.detail#">
		</cfcatch>		
		</cftry>
		<cfreturn qBookDetails> 			
	</cffunction>
</cfcomponent>--->