<!---
Name    : appCoreSelector.cfm
Author  : Akbarsait (akbarsaitn.cfmx@gmail.com)
Purpose	: CF Application Core Files Selector. 
--->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput> 
<response showresponse="true">  
	<ide handlerfile="appCoreCreator.cfm"> 
		<dialog width="400" height="330">  
			<input 
				name="appVersion" 
				Lable="Select ColdFusion Version" 
				type="list" required="false" 
				tooltip="Select ColdFusion version to Create AppCore Files" 
				default="ColdFusion 9">
					<option value="ColdFusion 9" />
					<option value="ColdFusion 8" />
					<option value="ColdFusion MX 7" />
			</input>
			<input 
				name="Application Name" 
				label="Application Name"
				tooltip="Enter Application Name"  
				type="string" 
				required="true" />
		</dialog>
	</ide>
</response>
</cfoutput>