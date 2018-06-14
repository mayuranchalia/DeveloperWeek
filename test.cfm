
<cfscript>
		admin = createobject("component","CFIDE.adminapi.administrator");
		admin.login("admin","admin");
		restApi = createobject("component","CFIDE.adminapi.extensions");
		services = restApi.getRESTServices();
		writeDump(services);
		//services.deleteRESTService("C:\ColdFusion2016\cfusion\wwwroot\developerweek");
		
		services.registerRESTService("dw","C:\ColdFusion2016\cfusion\wwwroot\developerweek");
</cfscript>