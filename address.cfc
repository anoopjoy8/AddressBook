
<cfcomponent displayName='address' hint='mult'>

     <cffunction  name="delete">
        <cfset userdelete  = EntityLoadByPK("giggidy",#url.delete#) />
        <cfset EntityDelete(userdelete) />
        <cflocation url = "http://127.0.0.1:8500/tasks/addressbook/page.cfm" addToken = "no"> 
     </cffunction>

    <cffunction  name="view">
        <cfset errorStruct       = {} />
        <cfset errorStruct.val   = {} />
        <cfset errorStruct.error = {} />
        <cfset usersdet          = EntityLoadByPK("giggidy", #url.view#) />
        <cfset errorStruct.modalstat   = 'hide'/>
        <cfset errorStruct.modalstat2  = 'show'/>
        <cfset errorStruct.val = {fname="#usersdet.fname#",sname="#usersdet.sname#",gender="#usersdet.gender#",email="#usersdet.email#",dob="#usersdet.dob#",phone="#usersdet.phone#",address="#usersdet.address#",street="#usersdet.street_name#",photo="#usersdet.photo#"} />
        <cfreturn errorStruct> 
    </cffunction>

    <cffunction  name="add" access="public" output="false"> 
        <cfargument name="fname"   required="true">
        <cfargument name="sname"   required="true"> 
        <cfargument name="gender"  required="true">
        <cfargument name="dob"     required="true">
        <cfargument name="email"   required="true">
        <cfargument name="phno"    required="true">
        <cfargument name="image"   required="true">
        <cfargument name="address" required="true">
        <cfargument name="street"  required="true"> 

        <cfset var errorStruct = {} />
        <cfset var errorStruct.error = {} />
        <cfset var errorStruct.val   = {} />
        <cfset var modalStruct = {} />
        <cfset errorStruct.insert("modalstat2",'hide',true)/>
        <!--- validate fullname --->
        <cfif arguments.fname EQ "">
            <cfscript> errorStruct.error.insert("1",'Please enter full name',true);  </cfscript>
            <cfscript> errorStruct.val.insert("fname",'#arguments.fname#',true);  </cfscript>
        <cfelse>
             <cfscript> errorStruct.val.insert("fname",'#arguments.fname#',true);  </cfscript>
        </cfif>
        <!--- validate secondname --->
        <cfif arguments.sname EQ "">
            <cfscript> errorStruct.error.insert("2",'Please enter second name',true);  </cfscript>
            <cfscript> errorStruct.val.insert("sname",'#arguments.sname#',true);  </cfscript>
        <cfelse>
             <cfscript> errorStruct.val.insert("sname",'#arguments.sname#',true);  </cfscript>
        </cfif>
        <!--- validate gender --->
        <cfif arguments.gender EQ "">
            <cfscript> errorStruct.error.insert("3",'Please select a gender',true);  </cfscript>
            <cfscript> errorStruct.val.insert("gender",'#arguments.gender#',true);  </cfscript>
        <cfelse>
             <cfscript> errorStruct.val.insert("gender",'#arguments.gender#',true);  </cfscript>
        </cfif>
        <!--- validate dob --->
        <cfif arguments.dob EQ "">
            <cfscript> errorStruct.error.insert("4",'Please enter DOB',true);  </cfscript>
            <cfscript> errorStruct.val.insert("dob",'#arguments.dob#',true);  </cfscript>
        <cfelse>
            <cfscript> errorStruct.val.insert("dob",'#arguments.dob#',true);  </cfscript>
        </cfif>
        <!--- validate email --->
        <cfif Not isValid('email',arguments.email)>
            <cfscript> errorStruct.error.insert("5",'Please provide correct email',true);  </cfscript>
            <cfscript> errorStruct.val.insert("email",'#arguments.email#',true);  </cfscript>
        <cfelse>
             <cfscript> errorStruct.val.insert("email",'#arguments.email#',true);  </cfscript>
        </cfif>
        <!--- validate phone --->
        <cfif arguments.phno EQ "">
            <cfscript> errorStruct.error.insert("6",'Please enter Phone no',true);  </cfscript>
            <cfscript> errorStruct.val.insert("phone",'#arguments.phno#',true);  </cfscript>
        <cfelse>
            <cfscript> errorStruct.val.insert("phone",'#arguments.phno#',true);  </cfscript>
        </cfif>
        <!--- validate address --->
        <cfif arguments.address EQ "">
            <cfscript> errorStruct.error.insert("7",'Please enter address',true);  </cfscript>
            <cfscript> errorStruct.val.insert("address",'#arguments.address#',true);  </cfscript>
        <cfelse>
             <cfscript> errorStruct.val.insert("address",'#arguments.address#',true);  </cfscript>
        </cfif>
        <!--- validate street --->
        <cfif arguments.street EQ "">
            <cfscript> errorStruct.error.insert("8",'Please enter street address',true);  </cfscript>
            <cfscript> errorStruct.val.insert("street",'#arguments.street#',true);  </cfscript>
        <cfelse>
            <cfscript> errorStruct.val.insert("street",'#arguments.street#',true);  </cfscript>
        </cfif>
        <cfscript> errorStruct.val.insert("photo",'#arguments.image#',true);  </cfscript>
        <cfif StructIsEmpty(errorStruct.error) EQ "false">
             <cfscript> errorStruct.insert("modalstat",'show',true);  </cfscript>
            <cfreturn errorStruct>
        <cfelse>
        
            <cfscript> errorStruct.insert("modalstat",'hide',true);  </cfscript>
            <cffile 
                action = "upload" 
                fileField = "image" 
                destination="C:\ColdFusion2021\cfusion\wwwroot\tasks\addressbook\public\files"
                allowedExtensions="jpg"
                result='fileUploadResult'
                nameConflict = makeunique
            >
           
            <cfset  address_contacts = new AddressBookOrm()/>
            <cfset  address_contacts.setfname("#arguments.fname#")/>
            <cfset  address_contacts.setsname("#arguments.sname#")/>
            <cfset  address_contacts.setemail("#arguments.email#")/>
            <cfset  address_contacts.setgender("#arguments.gender#")/>
            <cfset  address_contacts.setdob("#DateFormat(arguments.dob,'yyyy-mm-dd')#")/>
            <cfset  address_contacts.setphoto("#fileUploadResult.clientFile#")/>
            <cfset  address_contacts.setphone("#arguments.phno#")/>
            <cfset  address_contacts.setaddress("#arguments.address#")/>
            <cfset  address_contacts.setstreet_name("#arguments.street#")/>

            <cfset EntitySave(address_contacts) />
            <cfscript>writeOutput(address_contacts.getid());</cfscript>
            <cfreturn errorStruct>    
        </cfif>

    </cffunction>

    <cffunction  name="get_det">
        <cfset errorStruct       = {} />
        <cfset errorStruct.val   = {} />
        <cfset errorStruct.error = {} />
        <cfset usersdet          = EntityLoadByPK("giggidy", #url.edit#) />
        <cfset errorStruct.modalstat   = 'show'/>
         <cfset errorStruct.modalstat2 = 'hide'/>
        
        <cfset errorStruct.val = {fname="#usersdet.fname#",sname="#usersdet.sname#",gender="#usersdet.gender#",email="#usersdet.email#",dob="#usersdet.dob#",phone="#usersdet.phone#",address="#usersdet.address#",street="#usersdet.street_name#",photo="#usersdet.photo#"} />
        <cfreturn errorStruct> 
    </cffunction>

    <cffunction  name="update">
        <cfargument name="fname"   required="true">
        <cfargument name="sname"   required="true"> 
        <cfargument name="gender"  required="true">
        <cfargument name="dob"     required="true">
        <cfargument name="email"   required="true">
        <cfargument name="phno"    required="true">
        <cfargument name="image"   required="true">
        <cfargument name="address" required="true">
        <cfargument name="street"  required="true"> 

        <cfset var errorStruct = {} />
        <cfset var errorStruct.error = {} />
        <cfset var errorStruct.val   = {} />
        <cfset var modalStruct = {} />
        <cfset errorStruct.insert("modalstat2",'hide',true)/>
        <!--- validate fullname --->
        <cfif arguments.fname EQ "">
            <cfscript> errorStruct.error.insert("1",'Please enter full name',true);  </cfscript>
            <cfscript> errorStruct.val.insert("fname",'#arguments.fname#',true);  </cfscript>
        <cfelse>
             <cfscript> errorStruct.val.insert("fname",'#arguments.fname#',true);  </cfscript>
        </cfif>
        <!--- validate secondname --->
        <cfif arguments.sname EQ "">
            <cfscript> errorStruct.error.insert("2",'Please enter second name',true);  </cfscript>
            <cfscript> errorStruct.val.insert("sname",'#arguments.sname#',true);  </cfscript>
        <cfelse>
             <cfscript> errorStruct.val.insert("sname",'#arguments.sname#',true);  </cfscript>
        </cfif>
        <!--- validate gender --->
        <cfif arguments.gender EQ "">
            <cfscript> errorStruct.error.insert("3",'Please select a gender',true);  </cfscript>
            <cfscript> errorStruct.val.insert("gender",'#arguments.gender#',true);  </cfscript>
        <cfelse>
             <cfscript> errorStruct.val.insert("gender",'#arguments.gender#',true);  </cfscript>
        </cfif>
        <!--- validate dob --->
        <cfif arguments.dob EQ "">
            <cfscript> errorStruct.error.insert("4",'Please enter DOB',true);  </cfscript>
            <cfscript> errorStruct.val.insert("dob",'#arguments.dob#',true);  </cfscript>
        <cfelse>
            <cfscript> errorStruct.val.insert("dob",'#arguments.dob#',true);  </cfscript>
        </cfif>
        <!--- validate email --->
        <cfif Not isValid('email',arguments.email)>
            <cfscript> errorStruct.error.insert("5",'Please provide correct email',true);  </cfscript>
            <cfscript> errorStruct.val.insert("email",'#arguments.email#',true);  </cfscript>
        <cfelse>
             <cfscript> errorStruct.val.insert("email",'#arguments.email#',true);  </cfscript>
        </cfif>
        <!--- validate phone --->
        <cfif arguments.phno EQ "">
            <cfscript> errorStruct.error.insert("6",'Please enter Phone no',true);  </cfscript>
            <cfscript> errorStruct.val.insert("phone",'#arguments.phno#',true);  </cfscript>
        <cfelse>
            <cfscript> errorStruct.val.insert("phone",'#arguments.phno#',true);  </cfscript>
        </cfif>
        <!--- validate address --->
        <cfif arguments.address EQ "">
            <cfscript> errorStruct.error.insert("7",'Please enter address',true);  </cfscript>
            <cfscript> errorStruct.val.insert("address",'#arguments.address#',true);  </cfscript>
        <cfelse>
             <cfscript> errorStruct.val.insert("address",'#arguments.address#',true);  </cfscript>
        </cfif>
        <!--- validate street --->
        <cfif arguments.street EQ "">
            <cfscript> errorStruct.error.insert("8",'Please enter street address',true);  </cfscript>
            <cfscript> errorStruct.val.insert("street",'#arguments.street#',true);  </cfscript>
        <cfelse>
            <cfscript> errorStruct.val.insert("street",'#arguments.street#',true);  </cfscript>
        </cfif>
        <cfscript> errorStruct.val.insert("photo",'#arguments.image#',true);  </cfscript>
        <cfif StructIsEmpty(errorStruct.error) EQ "false">
             <cfscript> errorStruct.insert("modalstat",'show',true);  </cfscript>
            <cfreturn errorStruct>
        <cfelse>
        
            <cfscript> errorStruct.insert("modalstat",'hide',true);  </cfscript>
            <cffile 
                action = "upload" 
                fileField = "image" 
                destination="C:\ColdFusion2021\cfusion\wwwroot\tasks\addressbook\public\files"
                allowedExtensions="jpg"
                result='fileUploadResult'
                nameConflict = makeunique
            >
 
            <cfset  address_contacts = EntityLoadByPK("giggidy", #url.edit#) />
            <cfset  address_contacts.setfname("#arguments.fname#")/>
            <cfset  address_contacts.setsname("#arguments.sname#")/>
            <cfset  address_contacts.setemail("#arguments.email#")/>
            <cfset  address_contacts.setgender("#arguments.gender#")/>
            <cfset  address_contacts.setdob("#DateFormat(arguments.dob,'yyyy-mm-dd')#")/>
            <cfset  address_contacts.setphoto("#fileUploadResult.clientFile#")/>
            <cfset  address_contacts.setphone("#arguments.phno#")/>
            <cfset  address_contacts.setaddress("#arguments.address#")/>
            <cfset  address_contacts.setstreet_name("#arguments.street#")/>
            <cfreturn errorStruct>    
        </cfif>
 
    </cffunction>
</cfcomponent>