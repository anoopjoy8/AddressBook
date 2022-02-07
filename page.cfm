
<cfset errorStruct             = {}/>
<cfset errorStruct.error       = {} />
<cfset headtitle               = "Add Contact" />
<cfset errorStruct.modalstat   = 'hide'/>
<cfset errorStruct.modalstat2  = 'hide'/>
<cfset fname   =""/>
<cfset sname   =""/>
<cfset gender  ="male"/>
<cfset email   =""/>
<cfset dob     =""/>
<cfset phone   =""/>
<cfset address =""/>
<cfset street  =""/>
<cfset photo   =""/>
<cfset u_id    =""/>

<cfset get_users = EntityLoad("giggidy") />

<!--- for error msg --->
<cfif structKeyExists(url, 'status')>
    <cfif url.status NEQ "view">
        <cfset errorStruct.modalstat   = 'show'/>
    <cfelse>
        <cfset errorStruct.modalstat2  = 'show'/>
    </cfif>
    <cfset fname   ="#url.fname#"/>
    <cfset sname   ="#url.sname#"/>
    <cfset gender  ="#url.gender#"/>
    <cfset dob     ="#url.dob#"/>
    <cfset email   ="#url.email#"/>
    <cfset phone   ="#url.phno#"/>
    <cfset address ="#url.address#"/>
    <cfset street  ="#url.street#"/>
    <cfset u_id    ="#url.u_id#"/>
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
                    <a class="nav-link active" href="components/address.cfc?method=pdfdownload"><img src="http://127.0.0.1:8500/tasks/addressbook/public/images/pdf.png" alt="Girl in a jacket" width="50" height="50"></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="components/address.cfc?method=exceldownload"><img src="http://127.0.0.1:8500/tasks/addressbook/public/images/word.png" alt="Girl in a jacket" width="50" height="50"></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="components/address.cfc?method=print"><img src="http://127.0.0.1:8500/tasks/addressbook/public/images/printer.png" alt="Girl in a jacket" width="50" height="50"></a>
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
                    <td><!-- <button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#modalcreate">Create Contact</button> -->
                    <a onclick="handleAdd('ok')"><button type="button" class="btn btn-outline-primary">Create Contact</button> </a>
                    </td>
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

                </div>
                </div>
            </div>
            </div>
        </div>

<!-- Modal1 -->
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
        <form  method="post" action="components/address.cfc?method=add" enctype="multipart/form-data" onsubmit="myFunction(event)">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputPassword1">First Name</label>
                        <span class="error" style="color:red;">*</span>
                        <cfoutput> 
                            <input type="text" class="form-control" name="fname" id="fname" placeholder="Enter first name" value="#fname#">
                            <span class="err" id="er1"></span> 
                        </cfoutput>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputPassword1">Second Name</label>
                        <span class="error" style="color:red;">*</span>
                        <cfoutput> 
                            <input type="text" class="form-control" name="sname" id="sname" placeholder="Enter second name" value="#sname#">
                            <span class="err" id="er2"></span> 
                            <input type="Hidden" name="modalstat" id="modalstat"   value="#errorStruct.modalstat#"> 
                            <input type="Hidden" name="modalstat2" id="modalstat2" value="#errorStruct.modalstat2#"> 
                            <input type="Hidden" name="update_id"  id="update_id"  value="#u_id#"> 
                        </cfoutput>
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
                            <input type="radio" value="male"   class="form-check-input" name="gender" id="gender" <cfif gender EQ "male"> checked </cfif>>Male
                            <input type="radio" value="female" class="form-check-input" name="gender" id="gender" <cfif gender EQ "female"> checked </cfif>>Female
                            <cfoutput> 
                                <span class="err" id="er3"></span> 
                            </cfoutput>
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
                            <cfoutput> 
                                <input type="text" class="jquery-datepicker__input datepicker1 form-control" name="dob" id="dob" value="#DateFormat(dob,'dd-mm-yyyy')#">
                                <span class="err" id="er4"></span>  
                            </cfoutput>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputPassword1">Email</label>
                        <span class="error" style="color:red;">*</span>
                        <cfoutput>
                            <input type="email" name="email" class="form-control" id="email" value="#email#" placeholder="Enter Email">
                            <span class="err" id="er5">
                                <cfif structKeyExists(url, 'status')> 
                                    <cfif url.status EQ "false">
                                         Email already exist 
                                    </cfif>
                                </cfif>
                            </span> 
                        </cfoutput>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputPassword1">Phone No</label>
                        <span class="error" style="color:red;">*</span>
                        <cfoutput> 
                            <input type="text" name="phno" class="form-control" id="phone" value="#phone#" placeholder="Enter Phone No">
                            <span class="err" id="er6"></span> 
                        </cfoutput>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <cfoutput> <input type="file" name="image"> #photo#</cfoutput>
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
                            <cfoutput>
                                <textarea class="form-control" name="address" id="address" rows="3">#address#</textarea>
                                <span class="err" id="er7"> </span> 
                            </cfoutput>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label for="exampleInputPassword1">Street</label>
                        <span class="error" style="color:red;">*</span>
                        <div class="mb-3">
                            <cfoutput> 
                                <textarea class="form-control" name="street" id="street" rows="3">#street#</textarea>
                                <span class="err" id="er8"> </span>
                            </cfoutput>
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



<!-- Modal2 -->
<cfoutput>
    <div class="modal fade" id="modalview" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLongTitle">#headtitle#</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
      
<div class="modal-body">
        <table class="table table-borderless">
        <tbody>
            <tr>
                <td>Name</td>
                <td> : </td>
                <td>#fname & '  '&sname#</td>
            </tr>
            <tr>    
                <td>Gender</td>
                <td> : </td>
                <td>#gender#</td>
            </tr>
            <tr>    
                <td>Date Of Birth</td>
                <td> : </td>
                <td>#DateFormat(dob,'dd-mm-yyyy')#</td>
            </tr>
            <tr>    
                <td>Address</td>
                <td> : </td>
                <td>#address#</td>
            </tr>
            <tr>    
                <td>Email</td>
                <td> : </td>
                <td>#email#</td>
            </tr>
            <tr>    
                <td>Phone</td>
                <td> : </td>
                <td>#phone#</td>
            </tr>
        </tbody>
    </table>
</div>
<div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
</div>
</div>
</div>
</div>
</cfoutput> 



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

             if(document.getElementById('modalstat2').value == "show")
             {
                $("#modalview").modal('show');
             }  
        });
        </script>

        <script>
        function handleAdd(val) {
            $("#modalcreate").modal('show');
        }
</script>

<script>
    function myFunction(event) {
            var fname       = document.getElementById('fname').value;
            var sname       = document.getElementById('sname').value;
            var gender      = document.getElementById('gender').value;
            var dob         = document.getElementById('dob').value;
            var email       = document.getElementById('email').value;
            var phone       = document.getElementById('phone').value;
            var address     = document.getElementById('address').value;
            var street      = document.getElementById('street').value;
            if(fname == ""){
                event.preventDefault();   
                document.getElementById('er1').innerHTML = "Please enter first name";    
            }
            else{
                document.getElementById('er1').innerHTML = "";
            }
            if(sname == ""){
                event.preventDefault();   
                document.getElementById('er2').innerHTML = "please  enter second name";    
            }
            else{
                document.getElementById('er2').innerHTML = "";
            }

            if(gender == ""){
                event.preventDefault();   
                document.getElementById('er3').innerHTML = "please  select a gender";    
            }
            else{
                document.getElementById('er3').innerHTML = "";
            }

            if(dob == ""){
                event.preventDefault();   
                document.getElementById('er4').innerHTML = "please  enter dob";    
            }
            else{
                document.getElementById('er4').innerHTML = "";
            }

            if(email == ""){
                event.preventDefault();   
                document.getElementById('er5').innerHTML = "please  enter email";    
            }
            else{
                document.getElementById('er5').innerHTML = "";
            }

            if(phone == ""){
                event.preventDefault();   
                document.getElementById('er6').innerHTML = "please  enter phone no";    
            }
            else{
                document.getElementById('er6').innerHTML = "";
            }

            if(address == ""){
                event.preventDefault();   
                document.getElementById('er7').innerHTML = "please  enter address";    
            }
            else{
                document.getElementById('er7').innerHTML = "";
            }

            if(street == ""){
                event.preventDefault();   
                document.getElementById('er8').innerHTML = "please  enter street name";    
            }
            else{
                document.getElementById('er8').innerHTML = "";
            }   
    }
</script>

</html>