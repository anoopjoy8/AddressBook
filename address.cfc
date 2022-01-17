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

    <cffunction  name="add">
        <cfquery datasource="cold">
            INSERT INTO cms_page (title, description)
            VALUES ('#arguments.p_title#', '#arguments.description#');
        </cfquery>
        <CFOUTPUT> Page Successfully added !! </CFOUTPUT> 
     </cffunction>

    <cffunction  name="edit">
        <cfquery name="getdet" datasource="cold">
            select * from cms_page WHERE id= #url.id#
        </cfquery>
        <cfscript>
            res = {title="#getdet.title#",description="#getdet.description#"};
            return res;
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