

// Make a spreadsheet object
<cfset spreadsheet = spreadsheetNew("Sheet A") />

// add a new sheet
<cfset spreadsheetCreateSheet(spreadsheet, "Sheet B") />

// set the new sheet to be the active one
<cfset SpreadsheetSetActiveSheet(spreadsheet, "Sheet B") />
// populate Sheet B
        <cfoutput>
            <cfset get_users = EntityLoad("giggidy") />
            <cfloop array="#get_users#" index="j" item="x">
               <cfset SpreadSheetAddRow(spreadsheet,'1,Detroit')/>
            </cfloop>
        </cfoutput>
<cfheader name="Content-Disposition" value="inline; filename=testFile.xls">
<cfcontent type="application/vnd.msexcel" variable="#SpreadSheetReadBinary(spreadsheet)#">