<cfcomponent>
    <cfset this.name = "Addressbook"/>
    <cfset this.datasource = "cold"/>
    <cfset this.ormEnabled = true/>
    <cfset this.sessionManagement = true/>
    <cfset this.ormSettings = { logsql : true } />
    <cfset this.invokeImplicitAccessor = true />

    <cffunction name="onRequest" access="public" returntype="boolean" output="true" hint="Executes the requested ColdFusion template.">
        <!--- Define arguments. --->
        <cfargument name="TargetPage" type="string" required="true" hint="The requested ColdFusion template." />
        <cfif arguments.TargetPage eq "/tasks/addressbook/sign-up.cfm">
            <cfinclude template="sign-up.cfm"> 
        <cfelseif StructKeyExists(session,"dataLoggedIn") eq "NO">
            <cfinclude template="index.cfm">
        <cfelse>
            <cfinclude template="page.cfm">
        </cfif>
        <cfreturn true />
    </cffunction>

    <cffunction name="onError">
    	<cfargument name="Exception" required=true/>
        <cfargument name="EventName" type="String" required=true/>
		<cfoutput>
            <h2>An unexpected error occurred.</h2>
            <p>Please provide the following information to technical support:</p>
            <p>Error Event: #EventName#</p>
            <p>Error details: #Exception.message#<br>
        </cfoutput>
    </cffunction>

    <cffunction name="onMissingTemplate" returnType="boolean">
        <cfargument type="string" name="targetPage" required=true/>
        <cfoutput>
            <h2>Template is missing.</h2>
        </cfoutput>
    </cffunction>

</cfcomponent>