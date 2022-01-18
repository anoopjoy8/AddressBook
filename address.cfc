
<cfcomponent displayName='address' hint='mult'>

    <cffunction  name="get">
        <cfquery name="getcontacts" datasource="cold">
            select * from address_contacts
        </cfquery>
        <cfreturn getcontacts>
     </cffunction>

     <cffunction  name="delete">
        <cfquery datasource="cold">
            DELETE FROM cms_page WHERE id=#url.del#;
        </cfquery>
        <cflocation url = "http://localhost:8500/tasks/cms/admin/page.cfm" addToken = "no"> 
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
        <cfset var valstruct   = {} />
        <cfset var modalStruct = {} />
        <!--- validate fullname --->
        <cfif arguments.fname EQ "">
            <cfscript> errorStruct.insert("1",'Please enter full name',true);  </cfscript>
            <cfscript> valstruct.insert("11",'',true);  </cfscript>
        <cfelse>
            <cfscript> valstruct.insert("11",#arguments.fname#,true);  </cfscript>
        </cfif>
        <!--- validate secondname --->
        <cfif arguments.sname EQ "">
            <cfscript> errorStruct.insert("2",'Please enter second name',true);  </cfscript>
            <cfscript> valstruct.insert("12",'',true);  </cfscript>
        <cfelse>
            <cfscript> valstruct.insert("12",#arguments.sname#,true);  </cfscript>
        </cfif>
        <!--- validate gender --->
        <cfif arguments.gender EQ "">
            <cfscript> errorStruct.insert("3",'Please select a gender',true);  </cfscript>
        </cfif>
        <!--- validate dob --->
        <cfif arguments.dob EQ "">
            <cfscript> errorStruct.insert("4",'Please enter DOB',true);  </cfscript>
            <cfscript> valstruct.insert("14",'',true);  </cfscript>
        <cfelse>
            <cfscript> valstruct.insert("14",DateFormat(#arguments.dob#,'dd-mm-yyyy'),true);  </cfscript>
        </cfif>
        <!--- validate email --->
        <cfif Not isValid('email',arguments.email)>
            <cfscript> errorStruct.insert("5",'Please provide correct email',true);  </cfscript>
            <cfscript> valstruct.insert("15",'',true);  </cfscript>
        <cfelse>
            <cfscript> valstruct.insert("15",#arguments.email#,true);  </cfscript>
        </cfif>
        <!--- validate phone --->
        <cfif arguments.phno EQ "">
            <cfscript> errorStruct.insert("6",'Please enter Phone no',true);  </cfscript>
            <cfscript> valstruct.insert("16",'',true);  </cfscript>
        <cfelse>
            <cfscript> valstruct.insert("16",#arguments.phno#,true);  </cfscript>
        </cfif>
        <!--- validate address --->
        <cfif arguments.address EQ "">
            <cfscript> errorStruct.insert("7",'Please enter address',true);  </cfscript>
            <cfscript> valstruct.insert("17",'',true);  </cfscript>
        <cfelse>
            <cfscript> valstruct.insert("17",#arguments.address#,true);  </cfscript>
        </cfif>
        <!--- validate street --->
        <cfif arguments.street EQ "">
            <cfscript> errorStruct.insert("8",'Please enter street address',true);  </cfscript>
            <cfscript> valstruct.insert("18",'',true);  </cfscript>
        <cfelse>
            <cfscript> valstruct.insert("18",#arguments.street#,true);  </cfscript>
        </cfif>
        <cfif StructIsEmpty(errorStruct) EQ "false">
            <cfscript> errorStruct.insert("modalstat",'show',true);  </cfscript>
            <cfreturn errorStruct>
        <cfelse>
            <cfreturn errorStruct>
            <cffile 
                action = "upload" 
                fileField = "image" 
                destination="C:\ColdFusion2021\cfusion\wwwroot\tasks\addressbook\public\files"
                allowedExtensions="jpg"
                result='fileUploadResult'
                nameConflict = makeunique
            >
            
           
            <cfset  address_contacts = new AddressBookOrm()/>
            <cfset  address_contacts.setfname("dsd")/>
            <cfset  address_contacts.setsname("Da vinci")/>
            <cfset  address_contacts.setemail("Paris12@goo.in")/>
            <cfset  address_contacts.setgender("male")/>
            <cfset  address_contacts.setdob("1993-08-02")/>
            <cfset  address_contacts.setphoto("adad.jpg")/>
            <cfset  address_contacts.setphone("123323")/>
            <cfset  address_contacts.setaddress("adadadadad")/>
            <cfset  address_contacts.setstreet_name("erwrqwcvbc")/>

            <cfset EntitySave(address_contacts) />
            <cfscript>writeOutput(address_contacts.getid());</cfscript>
            
            
            

        </cfif>

     </cffunction>

    <cffunction  name="get_det">
    <cfset var valstruct   = {} />
        <cfquery name="getdet" datasource="cold">
            select * from address_contacts WHERE id= #url.edit#
        </cfquery>
        <cfscript>
            valstruct.insert("11",#getdet.fname#,true); 
        </cfscript> 
        
    </cffunction>

    <cffunction  name="update">
        <cfquery datasource="cold">
            UPDATE cms_page
            SET title = '#arguments.p_title#', description= '#arguments.description#'
            WHERE id = #url.id#;
        </cfquery>
        Page Updated Successfully !!
        <cflocation url = "http://localhost:8500/tasks/cms/admin/page.cfm" addToken = "no"> 
    </cffunction>
</cfcomponent>