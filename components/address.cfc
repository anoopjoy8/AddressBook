
<cfcomponent displayName='address' hint='mult'>

     <cffunction  name="delete">
        <!--- <cfset userdelete  = EntityLoadByPK("giggidy",#url.delete#) />
        <cfset EntityDelete(userdelete) /> --->
        <cfquery name="dlt" datasource="cold" result="sResult">
            DELETE FROM address_contacts WHERE id= <CFQUERYPARAM VALUE="#url.delete#">;
        </cfquery>

        <cflocation url = "page.cfm" addToken = "no"> 
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
            <cfset  errorStruct.error.insert("1",'Please enter full name',true) />
            <cfset  errorStruct.val.insert("fname",'#arguments.fname#',true)  />
        <cfelse>
             <cfset errorStruct.val.insert("fname",'#arguments.fname#',true) />
        </cfif>
        <!--- validate secondname --->
        <cfif arguments.sname EQ "">
            <cfset errorStruct.error.insert("2",'Please enter second name',true) />
            <cfset errorStruct.val.insert("sname",'#arguments.sname#',true) />
        <cfelse>
            <cfset errorStruct.val.insert("sname",'#arguments.sname#',true) />
        </cfif>
        <!--- validate gender --->
        <cfif arguments.gender EQ "">
            <cfset errorStruct.error.insert("3",'Please select a gender',true)  />
            <cfset errorStruct.val.insert("gender",'#arguments.gender#',true)  />
        <cfelse>
            <cfset errorStruct.val.insert("gender",'#arguments.gender#',true) />
        </cfif>
        <!--- validate dob --->
        <cfif arguments.dob EQ "">
            <cfset errorStruct.error.insert("4",'Please enter DOB',true) />
            <cfset errorStruct.val.insert("dob",'#arguments.dob#',true) />
        <cfelse>
            <cfset errorStruct.val.insert("dob",'#arguments.dob#',true) />
        </cfif>
        <!--- validate email --->
        <cfif Not isValid('email',arguments.email)>
            <cfset errorStruct.error.insert("5",'Please provide correct email',true) />
            <cfset errorStruct.val.insert("email",'#arguments.email#',true) />
        <cfelse>
            <cfset errorStruct.val.insert("email",'#arguments.email#',true) />
                <!--- Check existance --->
            <cfquery name="check_email" datasource="cold" result="xResult">
                SELECT * FROM address_contacts
                WHERE email= <CFQUERYPARAM VALUE="#arguments.email#"  cfsqltype="cf_sql_varchar">;
            </cfquery>
            <cfif xResult.recordcount NEQ 0>
                <cfset errorStruct.error.insert("5",'Email already exist',true) />
            </cfif>

        </cfif>

            

        <!--- validate phone --->
        <cfif arguments.phno EQ "">
            <cfset  errorStruct.error.insert("6",'Please enter Phone no',true)  />
            <cfset  errorStruct.val.insert("phone",'#arguments.phno#',true)  />
        <cfelse>
            <cfset  errorStruct.val.insert("phone",'#arguments.phno#',true)  />
            <!--- Check existance --->
            <cfquery name="check_phone" datasource="cold" result="pResult">
                SELECT * FROM address_contacts
                WHERE phone= <CFQUERYPARAM VALUE="#arguments.phno#"  cfsqltype="cf_sql_varchar">;
            </cfquery>
            <cfif pResult.recordcount NEQ 0>
                    <cfset  errorStruct.error.insert("6",'Phone no already exist',true) />
            </cfif>
        </cfif>
        <!--- validate address --->
        <cfif arguments.address EQ "">
            <cfset  errorStruct.error.insert("7",'Please enter address',true)    />
            <cfset  errorStruct.val.insert("address",'#arguments.address#',true) />
        <cfelse>
            <cfset errorStruct.val.insert("address",'#arguments.address#',true) />
        </cfif>
        <!--- validate street --->
        <cfif arguments.street EQ "">
            <cfset  errorStruct.error.insert("8",'Please enter street address',true)  />
            <cfset  errorStruct.val.insert("street",'#arguments.street#',true) />
        <cfelse>
            <cfset  errorStruct.val.insert("street",'#arguments.street#',true)  />
        </cfif>
        <cfset      errorStruct.val.insert("photo",'#arguments.image#',true) />
        <cfif StructIsEmpty(errorStruct.error) EQ "false">
            <cfset errorStruct.insert("modalstat",'show',true)  />
            <cfreturn errorStruct>
        <cfelse>
        
            <cfset errorStruct.insert("modalstat",'hide',true)  />
            <cfif arguments.image NEQ "">
                <cffile 
                    action = "upload" 
                    fileField = "image" 
                    destination="F:\Coldfushion\cfusion\wwwroot\tasks\addressbook\public\files"
                    allowedExtensions="jpg"
                    result='fileUploadResult'
                    nameConflict = makeunique
                >
                <cfset img = #fileUploadResult.clientFile#>
            <cfelse>
                <cfset img = "">
            </cfif>
           


            <cfquery name="signupq" datasource="cold" result="sResult">
                INSERT INTO address_contacts (fname,sname,email,phone,gender,dob,photo,address,street_name)
                VALUES (<CFQUERYPARAM VALUE="#arguments.fname#"  cfsqltype="cf_sql_varchar">,
                        <CFQUERYPARAM VALUE="#arguments.sname#"  cfsqltype="cf_sql_varchar">,
                        <CFQUERYPARAM VALUE="#arguments.email#"  cfsqltype="cf_sql_varchar">,
                        <CFQUERYPARAM VALUE="#arguments.phno#"   cfsqltype="cf_sql_numeric">,
                        <CFQUERYPARAM VALUE="#arguments.gender#">,
                        <CFQUERYPARAM VALUE="#DateFormat(arguments.dob,'yyyy-mm-dd')#" cfsqltype="CF_SQL_DATE">,
                        <CFQUERYPARAM VALUE="#img#" cfsqltype="cf_sql_varchar">,
                        <CFQUERYPARAM VALUE="#arguments.address#" cfsqltype="cf_sql_varchar">,
                        <CFQUERYPARAM VALUE="#arguments.street#"  cfsqltype="cf_sql_varchar">);
            </cfquery>

            
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
            <cfset  errorStruct.error.insert("1",'Please enter full name',true) />
            <cfset  errorStruct.val.insert("fname",'#arguments.fname#',true) />
        <cfelse>
            <cfset  errorStruct.val.insert("fname",'#arguments.fname#',true) />
        </cfif>
        <!--- validate secondname --->
        <cfif arguments.sname EQ "">
            <cfset errorStruct.error.insert("2",'Please enter second name',true)  />
            <cfset errorStruct.val.insert("sname",'#arguments.sname#',true) />
        <cfelse>
            <cfset errorStruct.val.insert("sname",'#arguments.sname#',true) />
        </cfif>
        <!--- validate gender --->
        <cfif arguments.gender EQ "">
            <cfset  errorStruct.error.insert("3",'Please select a gender',true)  />
            <cfset  errorStruct.val.insert("gender",'#arguments.gender#',true)  />
        <cfelse>
            <cfset  errorStruct.val.insert("gender",'#arguments.gender#',true)  />
        </cfif>
        <!--- validate dob --->
        <cfif arguments.dob EQ "">
            <cfset errorStruct.error.insert("4",'Please enter DOB',true) />
            <cfset errorStruct.val.insert("dob",'#arguments.dob#',true) />
        <cfelse>
            <cfset errorStruct.val.insert("dob",'#arguments.dob#',true) />
        </cfif>
        <!--- validate email --->
        <cfif Not isValid('email',arguments.email)>
            <cfset errorStruct.error.insert("5",'Please provide correct email',true) />
            <cfset errorStruct.val.insert("email",'#arguments.email#',true) />
        <cfelse>
            <cfset errorStruct.val.insert("email",'#arguments.email#',true) />
                <!--- Check existance --->
            <cfquery name="check_email" datasource="cold" result="xResult">
                SELECT * FROM address_contacts
                WHERE email= <CFQUERYPARAM VALUE="#arguments.email#"  cfsqltype="cf_sql_varchar"> And id <> 
                            <CFQUERYPARAM VALUE="#url.edit#"  cfsqltype="cf_sql_INTEGER"> ;
            </cfquery>
            <cfif xResult.recordcount NEQ 0>
                    <cfset errorStruct.error.insert("5",'Email already exist',true) />
            </cfif>
        </cfif>
        <!--- validate phone --->
        <cfif arguments.phno EQ "">
            <cfset errorStruct.error.insert("6",'Please enter Phone no',true)  />
            <cfset errorStruct.val.insert("phone",'#arguments.phno#',true)  />
        <cfelse>
            <cfset errorStruct.val.insert("phone",'#arguments.phno#',true)  />
            <!--- Check existance --->
            <cfquery name="check_phone" datasource="cold" result="pResult">
                SELECT * FROM address_contacts
                WHERE phone= <CFQUERYPARAM VALUE="#arguments.phno#"  cfsqltype="cf_sql_varchar"> And id <> 
                             <CFQUERYPARAM VALUE="#url.edit#"  cfsqltype="cf_sql_INTEGER">;
            </cfquery>
            <cfif pResult.recordcount NEQ 0>
                    <cfset errorStruct.error.insert("6",'Phone no already exist',true) />
            </cfif>
        </cfif>
        <!--- validate address --->
        <cfif arguments.address EQ "">
            <cfset  errorStruct.error.insert("7",'Please enter address',true)  />
            <cfset  errorStruct.val.insert("address",'#arguments.address#',true) />
        <cfelse>
             <cfset errorStruct.val.insert("address",'#arguments.address#',true)  />
        </cfif>
        <!--- validate street --->
        <cfif arguments.street EQ "">
            <cfset  errorStruct.error.insert("8",'Please enter street address',true)  />
            <cfset  errorStruct.val.insert("street",'#arguments.street#',true)  />
        <cfelse>
            <cfset  errorStruct.val.insert("street",'#arguments.street#',true) />
        </cfif>
        <cfset  errorStruct.val.insert("photo",'#arguments.image#',true)  />
        <cfif StructIsEmpty(errorStruct.error) EQ "false">
             <cfset errorStruct.insert("modalstat",'show',true) />
            <cfreturn errorStruct>
        <cfelse>
        
            <cfset  errorStruct.insert("modalstat",'hide',true) />
            <cffile 
                action = "upload" 
                fileField = "image" 
                destination="F:\Coldfushion\cfusion\wwwroot\tasks\addressbook\public\files"
                allowedExtensions="jpg"
                result='fileUploadResult'
                nameConflict = makeunique
            >
            <cfquery name="updates" datasource="cold" result="sResult">
                UPDATE address_contacts SET 
                fname= <CFQUERYPARAM VALUE="#arguments.fname#"    cfsqltype="cf_sql_varchar">,
                sname = <CFQUERYPARAM VALUE="#arguments.sname#"   cfsqltype="cf_sql_varchar">,
                email = <CFQUERYPARAM VALUE="#arguments.email#"   cfsqltype="cf_sql_varchar">,
                phone = <CFQUERYPARAM VALUE="#arguments.phno#"    cfsqltype="cf_sql_varchar">,
                gender = <CFQUERYPARAM VALUE="#arguments.gender#">,
                dob = <CFQUERYPARAM VALUE="#DateFormat(arguments.dob,'yyyy-mm-dd')#" cfsqltype="cf_sql_date">,
                address = <CFQUERYPARAM VALUE="#arguments.address#"   cfsqltype="cf_sql_varchar">,
                street_name= <CFQUERYPARAM VALUE="#arguments.street#" cfsqltype="cf_sql_varchar"> 
                WHERE id=#url.edit#;
            </cfquery>
            <cfreturn errorStruct>    
        </cfif>
 
    </cffunction>
    <cffunction  name="pdfdownload">
        <cfset get_users = EntityLoad("giggidy") />
        <cfdocument format="PDF"  filename="file.pdf" overwrite="Yes">
        <!-- Theme style -->
        <link rel="stylesheet" href="http://127.0.0.1:8500/tasks/addressbook/public/css/adminlte.min.css">
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Phone Number</th>
                </tr>
            </thead>
            <tbody>
                <cfloop array="#get_users#" index="x">
                    <tr>
                        <td>#x.fname#</td>
                        <td>#x.email#</td>
                        <td>#x.phone#</td>
                    </tr>
                </cfloop>
                        
            </tbody>
        </table>
        </cfdocument> 
        <!-- <cfheader name="Content-Disposition" value="attachment;filename=file.pdf">
        <cfcontent type="application/octet-stream" file="#expandPath('.')#\file.pdf" deletefile="Yes"> -->
        <cfprint type="pdf" source="file.pdf" printer="HP LaserJet 4345 CS">
    </cffunction>
    
    <cffunction  name="exceldownload">
        <cfset get_users = EntityLoad("giggidy") />
        // Make a spreadsheet object
        <cfset spreadsheet = spreadsheetNew("Sheet A") />

        // add a new sheet
        <cfset spreadsheetCreateSheet(spreadsheet, "Sheet B") />

        // set the new sheet to be the active one
        <cfset SpreadsheetSetActiveSheet(spreadsheet, "Sheet B")/>

        // populate Sheet B
        <cfset SpreadsheetSetCellValue(spreadsheet, "Name",  1, 1) />
        <cfset SpreadsheetSetCellValue(spreadsheet, "Email", 1, 2)/>
        <cfset SpreadsheetSetCellValue(spreadsheet, "Phone", 1, 3) />
        <cfoutput>
            <cfloop array="#get_users#" index="j">
                <cfset SpreadSheetAddRow(spreadsheet,'#j.fname#,#j.email#,#j.phone#')/>
            </cfloop>
        </cfoutput>
        <cfheader name="Content-Disposition" value="inline; filename=testFile.xls">
        <cfcontent type="application/vnd.msexcel" variable="#SpreadSheetReadBinary(spreadsheet)#">
    </cffunction>

    <cffunction  name="print">
        <cfset get_users = EntityLoad("giggidy") />
        <cfdocument format="PDF"  filename="file.pdf" overwrite="Yes">
        <!-- Theme style -->
        <link rel="stylesheet" href="http://127.0.0.1:8500/tasks/addressbook/public/css/adminlte.min.css">
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Phone Number</th>
                </tr>
            </thead>
            <tbody>
                <cfloop array="#get_users#" index="x">
                    <tr>
                        <td>#x.fname#</td>
                        <td>#x.email#</td>
                        <td>#x.phone#</td>
                    </tr>
                </cfloop>
                        
            </tbody>
        </table>
        </cfdocument> 
        <cfprint type="pdf" source="file.pdf" printer="Microsoft Print to PDF">
    </cffunction>
</cfcomponent>