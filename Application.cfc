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
        <cfif cgi.script_name eq "/tasks/addressbook/sign-up.cfm">
            <cfinclude template="sign-up.cfm"> 
        <cfelseif StructKeyExists(session,"dataLoggedIn") eq "NO">
            <cfinclude template="index.cfm">
        <cfelse>
            <cfinclude template="page.cfm">
        </cfif>
        <cfreturn true />
    </cffunction>


</cfcomponent>