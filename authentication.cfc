<cfcomponent output="false">

<!--- validate user Signin --->
<cffunction  name="validateUser" access="public" output="false">
    <cfargument  name="username" type="string" required="true">
    <cfargument  name="pass"     type="string" required="true">
    <cfset var errorStructlog = {} />
    <!--- validate email --->
    <cfif arguments.username EQ "">
        <cfscript> errorStructlog.insert("1",'Please enter username or email',true);  </cfscript>
    </cfif>
    <!--- validate pass --->
    <cfif arguments.pass EQ "">
        <cfscript> errorStructlog.insert("2",'Please enter password',true);  </cfscript>
    </cfif>
    <cfreturn errorStructlog>
</cffunction>

<!--- validate user Signup --->
<cffunction  name="validateUsersignup" access="public" output="false" >
    <cfargument  name="fullname" type="string" required="true">
    <cfargument  name="username" type="string" required="true">
    <cfargument  name="email"    type="string" required="true">
    <cfargument  name="pass"     type="string" required="true">
    <cfargument  name="pass2"    type="string" required="true">

    <cfset var errorStruct = {} />
    <!--- validate fullname --->
    <cfif arguments.fullname EQ "">
        <cfscript> errorStruct.insert("1",'Please enter fullname',true);  </cfscript>
    </cfif>
    <!--- validate email --->
    <cfif Not isValid('email',arguments.email)>
       <cfscript> errorStruct.insert("2",'Please provide correct email',true);  </cfscript>
    </cfif>
     <!--- validate username --->
    <cfif arguments.username EQ "">
        <cfscript> errorStruct.insert("3",'Please enter username',true);  </cfscript>
    </cfif>
    <!--- validate pass --->
    <cfif arguments.pass EQ "">
        <cfscript> errorStruct.insert("4",'Please enter password',true);  </cfscript>
    </cfif>
    <!--- validate pass2 --->
    <cfif arguments.pass2 EQ "">
        <cfscript> errorStruct.insert("5",'Please enter confirm password',true);  </cfscript>
    </cfif>

    <!--- validate pass1&pass2 --->
    <cfif arguments.pass NEQ arguments.pass2>
        <cfscript> errorStruct.insert("6",'Password must match',true);  </cfscript>
    </cfif>
    <cfreturn errorStruct>
</cffunction>

<!--- Signup method --->
<cffunction  name="SignupMethod" access="public" output="false" returntype="boolean">

    <cfargument  name="fullname" type="string" required="true">
    <cfargument  name="username" type="string" required="true">
    <cfargument  name="email"    type="string" required="true">
    <cfargument  name="pass"     type="string" required="true">

    <cfset var loggedIn = false>
    <cfquery name="signupq" datasource="cold" result="sResult">
        INSERT INTO address_users (name,user_name,email,password)
        VALUES ('#arguments.fullname#', '#arguments.username#', '#arguments.email#', '#arguments.pass#');
    </cfquery>

    <cfif sResult.GENERATEDKEY neq "">
        <cfquery name="login_check" datasource="cold">
            SELECT * FROM address_users
            WHERE id='#sResult.GENERATEDKEY#';
        </cfquery>
        <cfset session.dataLoggedIn = {'username'=login_check.user_name,'log_id'=sResult.GENERATEDKEY}>
        <cfset var loggedIn = true>
    </cfif>
    <cfreturn loggedIn>
</cffunction>

<cfoutput>
<!--- Login method --->
<cffunction  name="loginMethod" access="public" output="false" returntype="boolean">
    <cfargument  name="uname"   type="string" required="true">
    <cfargument  name="psw"     type="string" required="true">
    <cfset var loggedIn = false>
    <cfquery name="login_check" datasource="cold">
        SELECT * FROM address_users
        WHERE user_name='#arguments.uname#' OR email='#arguments.uname#' AND password ='#arguments.psw#';
    </cfquery>
    <cfif login_check.recordCount EQ 1>
        <cfset session.dataLoggedIn = {'username'=login_check.user_name,'log_id'=login_check.id,'name'=login_check.name}>
        <cfset var loggedIn = true>
    </cfif>
    <cfreturn loggedIn>
</cffunction>
</cfoutput>

<!--- Logout Method --->
<cffunction  name="logoutMethod" access="public" output="false" returntype="void">
    <cfset structDelete(session,'dataLoggedIn')/>
    
</cffunction>

</cfcomponent>