<cfscript>
ORMReload()
</cfscript>
<cfset errorStruct = {}/>
<cfset headtitle = "Add Contact" />
<cfset errorStruct.modalstat = 'hide'/>
<cfset errorStruct.11 = ""/>
<cfset errorStruct.12 = ""/>
<cfset errorStruct.14 = ""/>
<cfset errorStruct.15 = ""/>
<cfset errorStruct.16 = ""/>
<cfset errorStruct.17 = ""/>
<cfset errorStruct.18 = ""/>

<cfif StructKeyExists(session,"dataLoggedIn") eq "NO">
   <cflocation url = "http://127.0.0.1:8500/tasks/addressbook/" addToken = "no"> 
<cfelse>
    <!--- <cfinvoke component='address' method="get" returnVariable='res'/> --->
    <cfset get_users = EntityLoad("giggidy") />
</cfif>

<cfif structKeyExists(form, 'submit')>  
    <cfset addmethod      = createObject("component",'address')/>
    <cfset errorStruct    = addmethod.add(form.fname,form.sname,form.gender,form.dob,form.email,form.phno,form.image,form.address,form.street) />
</cfif>

<cfif structKeyExists(url, 'edit')> 
    <cfset headtitle = "Edit Contact" />
    <cfset errorStruct.modalstat = 'show'/>
    <cfset get_one     = createObject("component",'address')/>
    <cfset ret         = get_one.get_det(url.edit) />
    
</cfif>


<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="google-signin-client_id" content="913310001804-pck8u89o0tp8eraor2m1jtcvdiqtbnd4.apps.googleusercontent.com">
  <title>Address Book | Anoop</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <cfinclude template = "header-script.cfm">
  <!--- datepicker --->
  <link href="http://127.0.0.1:8500/tasks/addressbook/public/css/datepicker/datepicker3.css" rel="stylesheet" />
</head>
<body>
 
        <cfinclude template = "header.cfm">
        <div class="newnav">
        <nav class="nav navbar-white bg-white justify-content-end navonly">
            <ul class="nav">
                <li class="nav-item">
                    <a class="nav-link active" href=""><img src="http://127.0.0.1:8500/tasks/addressbook/public/images/pdf.png" alt="Girl in a jacket" width="50" height="50"></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href=""><img src="http://127.0.0.1:8500/tasks/addressbook/public/images/word.png" alt="Girl in a jacket" width="50" height="50"></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href=""><img src="http://127.0.0.1:8500/tasks/addressbook/public/images/printer.png" alt="Girl in a jacket" width="50" height="50"></a>
                </li>
            </ul>
        </nav>

        <div class="row">
            <div class="col-sm-3">
                <div class="card">
                <div class="card-body cardstyle">
                    <img src="http://127.0.0.1:8500/tasks/addressbook/public/images/profile.png" alt="Girl in a jacket" width="100" height="100">
                    <br> 
                    <span id="weltext"><cfoutput>#session.dataLoggedIn.name# </cfoutput></span>
                    <br>
                    <br>
                    <td><button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#modalcreate">Create Contact</button></td>
                </div>
                </div>
            </div>
            <div class="col-sm-9">
                <div class="card">
                <div class="card-body">
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
                                <cfoutput>
                                    <tr>
                                    <td>#x.fname#</td>
                                    <td>#x.email#</td>
                                    <td>#x.phone#</td>
                                    <td><a href="http://127.0.0.1:8500/tasks/addressbook/page.cfm?edit=#x.id#"><button type="button" class="btn btn-outline-primary">Edit</button></td></a>
                                    <td><button type="button" class="btn btn-outline-primary">Delete</button></td>
                                    <td><button type="button" class="btn btn-outline-primary">View</button></td>
                                    </tr>
                                </cfoutput>
                            </cfloop>
                        
                        </tbody>
                    </table>

                </div>
                </div>
            </div>
            </div>
        </div>

<!-- Modal -->
<div class="modal fade" id="modalcreate" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header modalback">
        <cfoutput><h5 class="modal-title" id="exampleModalLongTitle">#headtitle#</h5> </cfoutput>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <!-- first section starts here -->
        <h5 class="mtitle"> Personal Contact </h5>
        <hr style="background-color: #040404;height: 1px;"/> 
        <form  method="post" enctype="multipart/form-data">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputPassword1">First Name</label>
                        <span class="error" style="color:red;">*</span>
                        <cfoutput>  <input type="text" class="form-control" name="fname" id="exampleInputPassword1" placeholder="Enter first name" value="#errorStruct.11#">
                        <cfif structKeyExists(errorStruct, 1)> <span class="err"> #errorStruct.1#</span> </cfif> </cfoutput>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputPassword1">Second Name</label>
                        <span class="error" style="color:red;">*</span>
                        <cfoutput> <input type="text" class="form-control" name="sname" id="exampleInputPassword1" placeholder="Enter second name" value="#errorStruct.12#">
                        <cfif structKeyExists(errorStruct, 2)> <span class="err"> #errorStruct.2#</span> </cfif>
                        <input type="Hidden" name="modalstat" id="modalstat" value="#errorStruct.modalstat#">  </cfoutput>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputPassword1">Gender</label>
                        <span class="error" style="color:red;">*</span>
                        <br>
                        <div class="form-check-inline">
                        <label class="form-check-label">
                            <input type="radio" value="male"   class="form-check-input" name="gender" checked>Male
                            <input type="radio" value="female" class="form-check-input" name="gender">Female
                            <cfoutput> <cfif structKeyExists(errorStruct, 3)> <span class="err"> #errorStruct.3#</span> </cfif> </cfoutput>
                        </label>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputPassword1">Date of birth</label>
                        <span class="error" style="color:red;">*</span>
                        <br>
                        <div class="jquery-datepicker">
                            <cfoutput> <input type="text" class="jquery-datepicker__input datepicker1 form-control" name="dob" value="#errorStruct.14#">
                            <cfif structKeyExists(errorStruct, 4)> <span class="err"> #errorStruct.4#</span> </cfif> </cfoutput>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputPassword1">Email</label>
                        <span class="error" style="color:red;">*</span>
                        <cfoutput><input type="email" name="email" class="form-control" id="" value="#errorStruct.15#" placeholder="Enter Email">
                        <cfif structKeyExists(errorStruct, 5)> <span class="err"> #errorStruct.5#</span> </cfif> </cfoutput>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputPassword1">Phone No</label>
                        <span class="error" style="color:red;">*</span>
                        <cfoutput> <input type="text" name="phno" class="form-control" id="" value="#errorStruct.16#" placeholder="Enter Phone No">
                        <cfif structKeyExists(errorStruct, 6)> <span class="err"> #errorStruct.6#</span> </cfif> </cfoutput>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <input type="file" name="image">
                    </div>
                </div>
            </div>
            <!-- another section starts here -->
            <h5 class="mtitle"> Contact Details </h5>
            <hr style="background-color: #040404;height: 1px;"/> 

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputPassword1">Address</label>
                        <span class="error" style="color:red;">*</span>
                        <div class="mb-3">
                            <cfoutput><textarea class="form-control" name="address" id="exampleFormControlTextarea1" rows="3">#errorStruct.17#</textarea>
                            <cfif structKeyExists(errorStruct, 7)> <span class="err"> #errorStruct.7#</span> </cfif> </cfoutput>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputPassword1">Street</label>
                        <span class="error" style="color:red;">*</span>
                        <div class="mb-3">
                            <cfoutput> <textarea class="form-control" name="street" id="exampleFormControlTextarea1" rows="3">#errorStruct.18#</textarea>
                            <cfif structKeyExists(errorStruct, 8)> <span class="err"> #errorStruct.8#</span> </cfif> </cfoutput>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button type="submit" name="submit" class="btn btn-primary">Save changes</button>
        </div>
      </form>
    </div>
  </div>
</div>

</body>
    <!-- jQuery -->
    <script src="http://127.0.0.1:8500/tasks/addressbook/public/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="http://127.0.0.1:8500/tasks/addressbook/public/jquery/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="http://127.0.0.1:8500/tasks/addressbook/public/adminlte.min.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="http://127.0.0.1:8500/tasks/addressbook/public/demo.js"></script>
    
    <script src="http://127.0.0.1:8500/tasks/addressbook/public/css/datepicker/bootstrap-datepicker.js"/></script>
      <script type="text/javascript">
   // $('.jquery-datepicker').datepicker();

        $('.datepicker1').datepicker
        ({

            autoclose: true,
            todayHighlight: true,
            format: 'dd-mm-yyyy'
        });

        </script>

      

        
        <script>
        $( document ).ready(function() {
            
             if(document.getElementById('modalstat').value == "show")
             {
                $("#modalcreate").modal('show');
             } 
        });
        </script>

</html>
