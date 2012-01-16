<!---
Name    : appCoreCreator.cfm
Author  : Akbarsait (akbarsaitn.cfmx@gmail.com)
Purpose	: Application Core Files Creator. 
--->
<cfparam name="ideeventinfo" 	default="" />
<cfparam name="message"		 	default="" />
<cfparam name="messageType"	 	default="" />
<cfparam name="errorflag" 	 	default="0" />
<cfparam name="appCoreName"  	default="" />
<cfparam name="appCoreVersion"      	default="" />
<cfparam name="appCoreSelectorVersion"  default="" />

<cftry>	
	<!--- Parsing and Handling the ColdFusion Builder Event Information --->
	<cfset appCorexmlData 	= 	xmlParse(ideeventinfo) />

	<cfif appCorexmlData.event.user.input[1].xmlAttributes.name EQ "appVersion">
		<cfset appCoreSelectorVersion 	=	appCorexmlData.event.user.input[1].xmlAttributes["value"] />
	</cfif>
	<cfif appCorexmlData.event.user.input[2].xmlAttributes.name EQ "Application Name">
		<cfset appCoreName 	=	appCorexmlData.event.user.input[2].xmlAttributes["value"] />
	</cfif>

	<cfset appCoreprojectName		= 	appCorexmlData.event.ide.projectview.xmlAttributes["projectname"] />	
	<cfset appCoreDestinationPath 	= 	appCorexmlData.event.ide.projectview.resource.xmlAttributes["path"] />

	<!--- Setting the default Application core version as 9 --->
	<cfset appCoreVersion = 9 />
	<cfif Trim(appCoreSelectorVersion) EQ "ColdFusion MX 7">
		<cfset appCoreVersion = 7 />
	<cfelseif Trim(appCoreSelectorVersion) EQ "ColdFusion 8">
		<cfset appCoreVersion = 8 />
	</cfif>

	<!--- Setting the Application Name entered by the user in Application.cfc--->
	<cffile 
		action="read" 
		file="#ExpandPath('../appcorefiles/')#Application#appCoreVersion#.cfc" 
		variable="appCoreFile" />
		
	<cfset appCoreFile = ReplaceNoCase(appCoreFile, "[applicationName]", appCoreName) />
	
	<!--- Copying the ColdFusion Application Core Files--->
	<cffile 
		action="write" 
		output="#appCoreFile#" 
		file="#appCoreDestinationPath#/Application.cfc" />

	<cffile 
		action="copy" 	
		source="#ExpandPath('../appcorefiles/index.cfm')#" 
		destination="#appCoreDestinationPath#/index.cfm" />
	<cffile 
		action="copy" 	
		source="#ExpandPath('../appcorefiles/error.html')#" 
		destination="#appCoreDestinationPath#/error.html" />
		
	<!--- Filtering ColdFusion MX 7 for Missing Template Handler --->
	<cfif appCoreVersion NEQ 7>
		<cffile 
			action="copy"	
			source="#ExpandPath('../appcorefiles/404.cfm')#" 
			destination="#appCoreDestinationPath#/404.cfm" />
	</cfif>

	<!--- Handling errors. --->
	<cfcatch type="any">
		<cfset errorFlag 	= 1 />
		<cfset messageType  = "error" />
		<cfset message 		=  "Some Error has occurred!. " & cfcatch.message />
	</cfcatch> 	

</cftry>

<!--- Setting up a success message --->
<cfif NOT errorFlag>
	<cfset messageType  = "success" />
	<cfset message 		= appCoreSelectorVersion & " Application Core Files are successfully created to: " & appCoreDestinationPath />
</cfif>

<!--- Status message to the user about the success/failure of appCore file creation. --->
<cfsavecontent variable="statusmessage">
<cfoutput>
<response status="#messageType#" showresponse="true">  
	<ide>  
		<dialog width="460" height="300" />  
		<body>
			#message#
		</body>
		<commands> 
			<command type="refreshFolder">
				<params>
					<param key="foldername" value="#appCoreDestinationPath#" />
					<param key="projectname" value="#appCoreprojectName#" />
				</params> 
			</command>
		</commands>
	</ide>
</response>
</cfoutput>
</cfsavecontent>
<cfheader name="Content-Type" value="text/xml"><cfoutput>#statusmessage#</cfoutput>