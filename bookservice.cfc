component  restpath="books" rest="true"    
{
	
	/*
	* Function to retrieve Boook Details with specified ID
	*/
	remote function getbookDetails(required String bookid restargsource = "path" restargname="bookid" ) restpath="{bookid}" produces="application/json,application/xml" 
	httpmethod="GET" returntype="book" description="Get a book with specific id" responseMessages="404:Not found,200:Successful" {
		
		if(!isnumeric(arguments.bookid)){
			throw("Bad Request","400","Bookid should be numeric","400");
		}			
		qparams = {bookid={value=arguments.bookid , cfsqltype ='cf_sql_varchar'}};
		resultset = queryExecute("select b.bookid, a.firstname, a.lastname, a.authorid, b.title, b.bookimage, b.bookdescription, b.isspotlight, b.genre
					from books b, authors a
					where a.authorid = b.authorid
					and b.bookid = :bookid", qparams,{datasource = "cfbookclub"});
		if(!resultset.recordcount> 0){
			throw("Book not found", "404", "A book with ID #arguments.bookid# was not found","404");
		}
		book = createObject("component", "book");
		book.BookId = resultset.BOOKID;
		book.AuthorId = resultset.AUTHORID;
		book.AuthorName = resultset.FIRSTNAME;
		book.Title = resultset.TITLE;
		book.Genre = resultset.GENRE;
		book.Description = resultset.BOOKDESCRIPTION;
		return book;
	}  

    /* Function to return all the Books in the repository
    * 
    */
	remote function getbooks() produces="application/json,application/xml" httpmethod="GET" description="Get list of books" returntype="Query" {
	   	
	   	resultset = queryExecute("select b.bookid, b.title,b.authorid, b.bookimage, b.bookdescription, b.isspotlight, b.genre from books b",[],
	   		{datasource = "cfbookclub"});
	   		if(!resultset.recordcount> 0){
			throw("Books not found", "404", "No books found","404");
		}
		return resultset;
	}  
	    
	/*
	* Add Book to the repository
	*
	*/
	remote function addBook(required Struct structData restargsource = "body" ) consumes="application/json" produces="application/json"  
		httpmethod="POST" description="Add a new book" returntype="void" {
		if(isnull(structData.authorid)){
	          throw("Bad Request","400","AuthorId should be provided","400");
	                       	}
	    if(isnull(structData.title)){
	          throw("Bad Request","400","Title not provided","400");
	                       	}
	    if(isnull(structData.bookdescription)){
	          throw("Bad Request","400","Book Description not provided","400");
	                       	}
	    if(isnull(structData.genre)){
	          throw("Bad Request","400","Book Genre not provided","400");
	                       	}
	    try{
	       resultset = queryExecute("insert into books (bookid, authorid, title, bookimage,thumbnailimage, bookdescription, isspotlight, genre) values
	       	(#structData.bookid#, #structData.authorid#, '#trim(structData.title)#', '#trim(structData.bookimage)#', '#trim(structData.thumbnailimage)#', 
	       	'#trim(structData.bookdescription)#', 'Y', '#trim(structData.genre)#')",[],
	   		{datasource = "cfbookclub"}); 
	   		
	   	}catch( any exception){
	   		 //writeDump("#exception#","console");
	   		 throw("Server Error","500",exception.detail,"500");
	   	}  
	   		customresponse = structnew();
	   		customresponse.status = "201";
	   		customresponse.content = "Successfully added book with id #structData.bookid# to the repository";
	   		customresponse.headers = structnew();
	   		customResponse.headers.location = "http://www.adobe.com";
	   		restSetResponse(customresponse);
	   	    // Add custom response here to tell 201 book resource created     
	    	//return "Successfully added the book";
	    }
	    
	 /*
	  * Delete a Book with specified ID from the repository
	 */ 
	 remote function deleteBook(required numeric bookid restargsource = "query" ) httpmethod="DELETE" description="Deletes book of given Id" 
	  			returntype="String" produces="text/plain"  {
	  	if(!isnumeric(arguments.bookid)){
			throw("Bad Request","400","Bookid should be numeric","400");
		}
		try{
		qparams = {bookid={value=arguments.bookid , cfsqltype ='cf_sql_varchar'}};
		queryexecute("delete from books where bookid = :bookid",qparams,{datasource = "cfbookclub"});
		}catch (any exception){
			 throw("Server Error","500",exception.detail,"500");
		}
	
		
		return "Successfully deleted the book";
		
	  } 
	  
	  remote function updateBook(required numeric bookid restargsource = "path" restargname="bookid",
	  									string title restargsource ="Form" restargname="title",
	  									string description restargsource ="Form" restargname="description") returntype="String" httpmethod="PUT" restpath="{bookid}" 
	   						description=" Updates book with given id" consumes="application/x-www-form-urlencoded" {
	  		if(!isnumeric(bookid)){
			throw("Bad Request","400","Bookid should be numeric","400");
			}
			try{
			qparams = {bookid={value=arguments.bookid , cfsqltype ='cf_sql_varchar'}};
			queryexecute("update books SET TITLE='#title#',BOOKDESCRIPTION='#description#' where bookid = :bookid",qparams,{datasource = "cfbookclub"});
			}catch (any exception){
			 throw("Server Error","500",exception.detail,"500");
			}
			return "Successfully updated the book";
	  }          
}

