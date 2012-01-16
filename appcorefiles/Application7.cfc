<cfcomponent hint="I am a ColdFusion 7 Application.cfc File" output="false">
	
	<!--- ColdFusion 7 Application variables --->
	<cfset this.name 				= "[applicationName]">
	<cfset this.applicationTimeout	= createTimeSpan(0,2,0,0)>
	<cfset this.clientManagement 	= false>
	<cfset this.clientStorage 		= "registry">
	<cfset this.loginStorage 		= "session">
	<cfset this.sessionManagement 	= true>
	<cfset this.sessionTimeout 		= createTimeSpan(0,0,20,0)>
	<cfset this.setClientCookies 	= true>
	<cfset this.setDomainCookies 	= false>
	<cfset this.scriptProtect 		= "none">

	
	<!--- ColdFusion 7 Application Methods --->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfreturn true>
	</cffunction>

	<cffunction name="onApplicationEnd" returnType="void" output="false">
		<cfargument name="applicationScope" required="true">
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
</cfcomponent>