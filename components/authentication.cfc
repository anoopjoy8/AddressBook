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
        <cfelse>
             <!--- Check existance --->
            <cfquery name="check_email" datasource="cold" result="xResult">
                SELECT * FROM address_users
                WHERE email= <CFQUERYPARAM VALUE="#arguments.email#"  cfsqltype="cf_sql_varchar">;
            </cfquery>
            <cfif StructIsEmpty(xResult) EQ "false">
                    <cfscript> errorStruct.error.insert("2",'Email already exist',true);  </cfscript>
            </cfif>
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
        <cfset   login_check = ormExecuteQuery( "FROM Loginorm WHERE user_name = '#arguments.uname#' or email = '#arguments.uname#' and password='#arguments.psw#' " ) /> 
        <cfif arrayIsEmpty(login_check ) EQ  "no">
            <cfset session.dataLoggedIn = {'username'=login_check[1].user_name,'log_id'=login_check[1].id,'name'=login_check[1].name}>
            <cfset var loggedIn = true>
        </cfif>
        <cfreturn loggedIn>
    </cffunction>
    </cfoutput>

    <!--- Logout Method --->
    <cffunction  name="logoutMethod" access="public" output="false" returntype="void">
        <cfset structDelete(session,'dataLoggedIn')/>
        <cflocation url ="http://127.0.0.1:8500/tasks/addressbook">
        
    </cffunction>

    <!--- Google signin --->
    <cffunction  name="googleMethod">
        <cfset var loggedIn = false>
        <cfoauth
        Type="Google"
        clientid="1009946409223-o59j27t0k6l9h4h9toop9asmuia42g4e.apps.googleusercontent.com" 
        scope="https://www.googleapis.com/auth/userinfo.email+https://www.googleapis.com/auth/userinfo.profile"
        secretkey="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" 
        result="googleLoginResult"  
        redirecturi="http://127.0.0.1:8500/tasks/addressbook/index.cfm?ul=google">
        <cfset   login_check = ormExecuteQuery( "FROM Loginorm WHERE email = '#googleLoginResult.other.email#'" ) />
        <cfif arrayIsEmpty(login_check ) EQ  "yes">
            <cfset  address_contacts = new LoginOrm()/>
            <cfset  address_contacts.setname("#googleLoginResult.other.given_name#")/>
            <cfset  address_contacts.setuser_name("#googleLoginResult.other.given_name#")/>
            <cfset  address_contacts.setemail("#googleLoginResult.other.email#")/>
            <cfset EntitySave(address_contacts) />
            
            <cfset   login_check = ormExecuteQuery( "FROM Loginorm WHERE id = '#address_contacts.getid()#'" ) />
            <cfif arrayIsEmpty(login_check ) EQ  "no">
                <cfset session.dataLoggedIn = {'username'=login_check[1].user_name,'log_id'=login_check[1].id,'name'=login_check[1].name}>
                <cfset var loggedIn = true>
            </cfif>
        <cfelse>
            <cfset session.dataLoggedIn = {'username'=login_check[1].user_name,'log_id'=login_check[1].id,'name'=login_check[1].name}>
            <cfset var loggedIn = true>
        </cfif>
        <cfreturn loggedIn>
    </cffunction>

    <!--- Facebook signin --->
    <cffunction  name="facebookMethod" output="yes" returntype="any" access="remote">
        <cfargument name="emailId">
        <cfargument name="firstName">
        <cfargument name="lastName">
        

            <cfset   login_check = ormExecuteQuery( "FROM Loginorm WHERE email = '#arguments.emailId#'" ) />
            <cfif arrayIsEmpty(login_check ) EQ  "yes">
                <cfset  address_contacts = new LoginOrm()/>
                <cfset  address_contacts.setname("#arguments.firstName#")/>
                <cfset  address_contacts.setuser_name("#arguments.firstName#")/>
                <cfset  address_contacts.setemail("#arguments.emailId#")/>
                <cfset EntitySave(address_contacts) />
                
                <cfset   login_check = ormExecuteQuery( "FROM Loginorm WHERE id = '#address_contacts.getid()#'" ) />
                <cfif arrayIsEmpty(login_check ) EQ  "no">
                    <cfset session.dataLoggedIn = {'username'=login_check[1].user_name,'log_id'=login_check[1].id,'name'=login_check[1].name}>
                    
                </cfif>
            <cfelse>
                <cfset session.dataLoggedIn = {'username'=login_check[1].user_name,'log_id'=login_check[1].id,'name'=login_check[1].name}>
            
            </cfif>
        
        

        <!--- now use your structure --->
        
    </cffunction>

</cfcomponent>