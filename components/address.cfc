
<cfcomponent displayName='address' hint='mult'>

    <cffunction  name="delete" access="remote">
        <!--- <cfset userdelete  = EntityLoadByPK("giggidy",#url.delete#) />
        <cfset EntityDelete(userdelete) /> --->
        <cfquery name="dlt" datasource="cold" result="sResult">
            DELETE FROM address_contacts WHERE id= <CFQUERYPARAM VALUE="#url.delete#">;
        </cfquery>
        <cflocation url = ".../page.cfm" addToken = "no"> 
    </cffunction>

    <cffunction  name="view" access="remote">
        <cfquery name="edit_det" datasource="cold" result="xResult">
            SELECT * FROM address_contacts
            WHERE id= <CFQUERYPARAM VALUE="#url.view#"  cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfif xResult.recordcount NEQ 0>
            <cflocation  url="../page.cfm?status=view&u_id=""&fname=#edit_det.fname#
            &sname=#edit_det.sname#&gender=#edit_det.gender#&dob=#edit_det.dob#
            &email=#edit_det.email#&phno=#edit_det.phone#&address=#edit_det.address#&street=#edit_det.street_name#" addtoken="no">
        </cfif>
    </cffunction>

    <cffunction  name="add" access="remote" output="false"> 
        <cfargument name="fname"      required="true">
        <cfargument name="sname"      required="true"> 
        <cfargument name="gender"     required="true">
        <cfargument name="dob"        required="true">
        <cfargument name="email"      required="true">
        <cfargument name="phno"       required="true">
        <cfargument name="image"      required="true">
        <cfargument name="address"    required="true">
        <cfargument name="street"     required="true">
        <cfargument name="update_id"  required="false"> 
        <cfif arguments.update_id EQ "">

            <!--- Check existance of email--->
            <cfquery name="check_email" datasource="cold" result="xResult">
                SELECT * FROM address_contacts
                WHERE email= <CFQUERYPARAM VALUE="#arguments.email#"  cfsqltype="cf_sql_varchar">;
            </cfquery>
            <cfif xResult.recordcount NEQ 0>
                <cflocation  url="../page.cfm?status=false&u_id=""&fname=#arguments.fname#
                    &sname=#arguments.sname#&gender=#arguments.gender#&dob=#arguments.dob#
                    &email=#arguments.email#&phno=#arguments.phno#&address=#arguments.address#&street=#arguments.street#" addtoken="no">
                <cfelse>
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
                <cfif sResult.GENERATEDKEY neq "">
                    <cflocation  url="../page.cfm" addtoken="no">
                </cfif>
            </cfif>
            <cfelse>
                <cfif arguments.image NEQ "">
                    <cffile 
                        action = "upload" 
                        fileField = "image" 
                        destination="F:\Coldfushion\cfusion\wwwroot\tasks\addressbook\public\files"
                        allowedExtensions="jpg"
                        result='fileUploadResult'
                        nameConflict = makeunique
                    >
                <cfelse>
                    <cfset img = "">
                </cfif>    
            
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
                    WHERE id=#arguments.update_id#;
                </cfquery>
                <cflocation  url=".../page.cfm" addtoken="no">
        </cfif>  
    </cffunction>

    <cffunction  name="get_det" access="remote" output="true">
        <cfquery name="edit_det" datasource="cold" result="xResult">
            SELECT * FROM address_contacts
            WHERE id= <CFQUERYPARAM VALUE="#url.edit#"  cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfif xResult.recordcount NEQ 0>
            <cflocation  url="../page.cfm?status=true&u_id=#edit_det.id#&fname=#edit_det.fname#
            &sname=#edit_det.sname#&gender=#edit_det.gender#&dob=#edit_det.dob#
            &email=#edit_det.email#&phno=#edit_det.phone#&address=#edit_det.address#&street=#edit_det.street_name#" addtoken="no">
        </cfif>
    </cffunction>

    <!--- Contact list component --->
    <cffunction name="contactListContent" access="public" output="true">
        <cfset get_users = EntityLoad("giggidy") />
        <cfsavecontent  variable="contactList">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Phone Number</th>
                    </tr>
                </thead>
                <tbody>
                    <cfloop array="#get_users#" item="x">                               
                            <cfoutput>
                                <tr>
                                    <td>#x.fname#</td>
                                    <td>#x.email#</td>
                                    <td>#x.phone#</td>
                                    <td><a href="components/address.cfc?method=get_det&edit=#x.id#"><button type="button"   class="btn btn-outline-primary">Edit</button></a></td>
                                    <td><a href="components/address.cfc?method=delete&delete=#x.id#"><button type="button" class="btn btn-outline-primary">Delete</button></a></td>
                                    <td><a href="components/address.cfc?method=view&view=#x.id#""><button type="button" class="btn btn-outline-primary">View</button></a></td>
                                </tr>
                            </cfoutput> 
                    </cfloop>   
                </tbody>
            </table>
        </cfsavecontent>
        <cfreturn contactList>
    </cffunction>

    <cffunction  name="pdfdownload" access="remote">
        <cfset list      = contactListContent()>
        <cfdocument format="PDF"  filename="file.pdf" overwrite="Yes">
        <!-- Theme style -->
        <link rel="stylesheet" href="http://127.0.0.1:8500/tasks/addressbook/public/css/adminlte.min.css">
        <cfoutput> #list# </cfoutput>
        </cfdocument> 
        <!-- <cfheader name="Content-Disposition" value="attachment;filename=file.pdf">
        <cfcontent type="application/octet-stream" file="#expandPath('.')#\file.pdf" deletefile="Yes"> -->
        <cfprint type="pdf" source="file.pdf" printer="HP LaserJet 4345 CS">
    </cffunction>
    
    <cffunction  name="exceldownload" access="remote">
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

    <cffunction  name="print" access="remote">
        <cfset get_users = EntityLoad("giggidy") />
        <cfset list      = contactListContent() />
        <cfdocument format="PDF"  filename="file.pdf" overwrite="Yes">
        <!-- Theme style -->
        <link rel="stylesheet" href="http://127.0.0.1:8500/tasks/addressbook/public/css/adminlte.min.css">
        <cfoutput>#list#</cfoutput>
        </cfdocument> 
        <cfprint type="pdf" source="file.pdf" printer="Microsoft Print to PDF">
    </cffunction>
</cfcomponent>