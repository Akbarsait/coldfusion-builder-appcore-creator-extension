<cfcomponent output="false" hint="ColdFusion 9 Application.cfc File">

	<!--- ColdFusion 9 Application variables --->
	<cfset this.name 					= "[applicationName]" />
	<cfset this.applicationTimeout 		= createTimeSpan(0,2,0,0) />
	<cfset this.clientManagement 		= false />
	<cfset this.clientStorage 			= "registry" />
	<cfset this.customtagpaths 			= "">
	<cfset this.googleMapKey			= "" />
	<cfset this.loginStorage 			= "session" />
	<cfset this.mappings 				= structNew() />
	<cfset this.serverSideFormValidation= false />
	<cfset this.sessionManagement 		= true />
	<cfset this.sessionTimeout 			= createTimeSpan(0,0,20,0) />
	<cfset this.setClientCookies 		= true>
	<cfset this.setDomainCookies 		= false>
	<cfset this.scriptProtect 			= "none">
	<cfset this.secureJSON 				= false>
	<cfset this.secureJSONPrefix 		= "">
	<cfset this.welcomeFileList 		= "">
	<cfset this.smtpserver 				= structNew() />
	<cfset this.timeout 				= createTimeSpan(0,0,10,0) />
	<cfset this.debugipaddress 			= "" />
	<cfset this.enablerobustexception 	= "">

	<!--- ColdFusion 9 ORM related settings --->
	<cfset this.ormenabled = true />
	<cfset this.datasource = "DatasourceName" />
	<cfset this.ormsettings.autogenmap 			= "" />
	<cfset this.ormsettings.cacheconfig 		= "" />
	<cfset this.ormsettings.cacheprovider 		= "" />
	<cfset this.ormsettings.catalog	 			= "" />
	<cfset this.ormsettings.cfclocation 		= "" />
	<cfset this.ormsettings.dbcreate 			= "" />
	<cfset this.ormsettings.dialect 			= "" />
	<cfset this.ormsettings.eventHandling 		= "" />
	<cfset this.ormsettings.evenHandler			= "" />
	<cfset this.ormsettings.flushAtRequestEnd 	= "" />
	<cfset this.ormsettings.logSQL 				= "" />
	<cfset this.ormsettings.ormConfig 			= "" />
	<cfset this.ormsettings.namingstrategy		= "" /> 
	<cfset this.ormsettings.saveMapping 		= "" />
	<cfset this.ormsettings.schema 				= "" />
	<cfset this.ormsettings.sqlscript			= "" />
	<cfset this.ormsettings.usedbformapping 	= "" />
	<cfset this.ormsettings.secondarycacheenabled = "" />
		
	<!--- ColdFusion 9 Application Methods --->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfreturn true>
	</cffunction>

	<cffunction name="onApplicationEnd" returnType="void" output="false">
		<cfargument name="applicationScope" required="true">
	</cffunction>
	
	<cffunction name="onCFCRequest" returnType="void"> 
		<cfargument type="string" name="cfcname"> 
		<cfargument type="string" name="method"> 
		<cfargument type="struct" name="args"> 
	</cffunction>
	
	<cffunction name="onError" returnType="void" output="false">
		<cfargument name="exception" required="true">
		<cfargument name="eventname" type="string" required="true">
		<cfset var errorcontent = "">
		
		<cflog file="appname_errorlog" text="#arguments.exception.message#">
		
		<cfsavecontent variable="errorcontent">
		<cfoutput>
			An error has been encountered at http://#cgi.server_name##cgi.script_name#?#cgi.query_string#<br />
			Time: #dateFormat(now(), "short")# #timeFormat(now(), "short")#<br />
			<cfdump var="#arguments.exception#" label="Error">
			<cfdump var="#form#" label="Form">
			<cfdump var="#url#" label="URL">
		</cfoutput>
		</cfsavecontent>
		
		<cfmail to="mailto@site.com" from="info@site.com" subject="ERROR: #arguments.exception.message# at ApplicationName" type="html">
			#errorcontent#
		</cfmail>
		<cflocation url="error.html" addToken="true">
	</cffunction>

	<cffunction name="onMissingTemplate" returnType="boolean" output="false">
		<cfargument name="thePage" required="true" type="string">
		<cflog file="ApplicationName" text="Invalid Page Request: #arguments.thePage# #cgi.query_string#">
		<cflocation url="404.cfm?thepage=#arguments.thePage#" addToken="false" statusCode="301">
	</cffunction>
	
	<cffunction name="onRequest" returnType="void">
		<cfargument name="thePage" type="string" required="true">
		<cfinclude template="#arguments.thePage#">
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="true">
		<cfreturn true>
	</cffunction>
	
	<cffunction name="onRequestEnd" returnType="void" output="false">
		<cfargument name="thePage" type="string" required="true">
	</cffunction>

	<cffunction name="onSessionStart" returnType="void" output="false">
	</cffunction>

	<cffunction name="onSessionEnd" returnType="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="applicationScope" type="struct" required="false">
	</cffunction>
	
	<cffunction name="onServerStart" returnType="void" output="false">
		<cflog	file="cf9serverstartup" text="ColdFusion 9 Server is starting up now." />
		<cfmail to="mailto@site.com" from="info@site.com" subject="Alert - ColdFusion 9 Server Stated">
			The ColdFusion 9 Server has just Started on <cfoutput>#dateFormat(now(), "short")# #timeFormat(now(), "short")##DateFormat(Now(), "mmm-dd-yyyy")#, #TimeFormat(Now(), "HH:mm:ss")#</cfoutput>. 
		</cfmail>
	</cffunction>

</cfcomponent>








