<cfcomponent output="false">
    <!--- validate user Signin --->
    <cffunction  name="validateUser" access="remote" output="false">
        <cfargument  name="username" type="string" required="true">
        <cfargument  name="pass"     type="string" required="true">

        <cfquery name="login_check" datasource="cold">
            SELECT * FROM address_users 
            WHERE user_name = <CFQUERYPARAM VALUE="#arguments.username#"cfsqltype="cf_sql_varchar"> 
                  and password = <CFQUERYPARAM VALUE="#arguments.pass#" cfsqltype="cf_sql_varchar">;
         </cfquery>
        <!--- checking for login result --->
        <cfif login_check.recordcount NEQ 0>
            <cfset session.dataLoggedIn = {'username'=login_check.user_name,'log_id'=login_check.id,'name'=login_check.name}>
            <cflocation  url="../page.cfm" addtoken="no">
        <cfelse>
            <cflocation  url="../index.cfm?status=false" addtoken="no">
        </cfif>
    </cffunction>

    <!--- Signup method --->
    <cffunction  name="SignupMethod" access="remote" output="false" returntype="boolean">

        <cfargument  name="name"       type="string" required="true">
        <cfargument  name="username"   type="string" required="true">
        <cfargument  name="email"      type="string" required="true">
        <cfargument  name="password"   type="string" required="true">

        <!--- Check existance of email --->
        <cfquery name="check_phone" datasource="cold" result="eResult">
            SELECT * FROM address_users
            WHERE email= <CFQUERYPARAM VALUE="#arguments.email#"  cfsqltype="cf_sql_varchar">;
        </cfquery>

        <cfif eResult.recordcount NEQ 0>
            <cflocation  url="../sign-up.cfm?status=false&name=#arguments.name#&user=#arguments.username#&email=#arguments.email#" addtoken="no">
        </cfif>

        <cfquery name="signupq" datasource="cold" result="sResult">
            INSERT INTO address_users (name,user_name,email,password)
            VALUES (<CFQUERYPARAM VALUE="#arguments.name#"  cfsqltype="cf_sql_varchar">, 
                    <CFQUERYPARAM VALUE="#arguments.username#"  cfsqltype="cf_sql_varchar">,
                    <CFQUERYPARAM VALUE="#arguments.email#"     cfsqltype="cf_sql_varchar">, 
                    <CFQUERYPARAM VALUE="#arguments.password#"      cfsqltype="cf_sql_varchar">);
        </cfquery>

        <cfif sResult.GENERATEDKEY neq "">
            <cfquery name="login_check" datasource="cold">
                SELECT *   FROM address_users
                WHERE id = <CFQUERYPARAM VALUE="#sResult.GENERATEDKEY#"     cfsqltype="cf_sql_integer">;
            </cfquery>
            <cfset session.dataLoggedIn = {'username'=login_check.user_name,'name'=login_check.name,'log_id'=sResult.GENERATEDKEY}>
            <cflocation  url="../page.cfm" addtoken="no">
        </cfif>
    </cffunction>

    <!--- Logout Method --->
    <cffunction  name="logoutMethod" access="remote" output="false" returntype="void">
        <cfset structDelete(session,'dataLoggedIn')/>
        <cflocation url ="http://127.0.0.1:8500/tasks/addressbook"> 
    </cffunction>

    <!--- Google signin --->
    <cffunction  name="googleMethod" access="remote">
        <cfoauth
            Type="Google"
            clientid="1009946409223-o59j27t0k6l9h4h9toop9asmuia42g4e.apps.googleusercontent.com" 
            scope="https://www.googleapis.com/auth/userinfo.email+https://www.googleapis.com/auth/userinfo.profile"
            secretkey="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" 
            result="googleLoginResult"  
            redirecturi="http://127.0.0.1:8500/tasks/addressbook/components/authentication.cfc?method=googleMethod"
        >

        <cfquery name="login_check" datasource="cold">
            SELECT * FROM address_users 
            WHERE email     = <CFQUERYPARAM VALUE=#googleLoginResult.other.email#     cfsqltype="cf_sql_varchar"> ;
         </cfquery>
        
        <cfif login_check.recordcount EQ 0>
            <cfquery name="signupq" datasource="cold" result="sResult">
                INSERT INTO address_users (name,user_name,email)
                VALUES (<CFQUERYPARAM VALUE="#googleLoginResult.other.given_name#"    cfsqltype="cf_sql_varchar">, 
                        <CFQUERYPARAM VALUE="#googleLoginResult.other.given_name#"    cfsqltype="cf_sql_varchar">,
                        <CFQUERYPARAM VALUE="#googleLoginResult.other.email#"         cfsqltype="cf_sql_varchar">);
            </cfquery>
            <cfif sResult.GENERATEDKEY neq "">
                <cfquery name="login_check1" datasource="cold">
                    SELECT * FROM address_users 
                    WHERE  email     = <CFQUERYPARAM VALUE="#googleLoginResult.other.email#"  cfsqltype="cf_sql_varchar"> 
                    and    id        = <CFQUERYPARAM VALUE="#sResult.GENERATEDKEY#"           cfsqltype="cf_sql_INTEGER">;
                </cfquery>
                <cfif login_check1.recordcount NEQ 0>
                    <cfset session.dataLoggedIn = {'username'=login_check1.user_name,'log_id'=login_check1.id,'name'=login_check1.name}>
                    <cflocation  url="../page.cfm" addtoken="no">
                </cfif>
            </cfif>
        <cfelse>
            <cfset session.dataLoggedIn = {'username'=login_check.user_name,'log_id'=login_check.id,'name'=login_check.name}>
            <cflocation  url="../page.cfm" addtoken="no">
        </cfif>
    </cffunction>

</cfcomponent>