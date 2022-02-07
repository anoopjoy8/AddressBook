<cfset status         = ""/>
<cfset name           = ""/>
<cfset username       = ""/>
<cfset email          = ""/>

<!--- for error msg --->
<cfif structKeyExists(url, 'status')> 
  <cfif url.status eq "false">
      <cfset status     = "false"/>
      <cfset name       = "#url.name#"/>
      <cfset username   = "#url.user#"/>
      <cfset email      = "#url.email#"/>
  </cfif>
</cfif>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Address Book | Anoop</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <cfinclude template = "header-script.cfm">
</head>
  
<body>
<cfinclude template = "header.cfm">
<div class="div-center">
  <div class="card border-0 shadow rounded-3 my-5 c1">
    <div class="row">
      <div class="card-body p-4 p-sm-5 bg">
          <i class="fas fa-address-book fa-7x cent"></i>
      </div>
    <cfoutput>
        <div class="card-body p-4 p-sm-5">
          <h5 class="card-title text-center mb-5">SIGN UP</h5>
            <form method="post" action="components/authentication.cfc?method=SignupMethod" onsubmit="myFunction(event)">
              <div class="form-floating mb-3">
                <input type="text" name="name" id="name" class="form-control" id="floatingInput" value="#name#" placeholder="Full Name">    <p class="err" id="er1"></p> 
              </div>
              <div class="form-floating mb-3">
                <input type="email" name="email"  id="email" class="form-control" id="floatingInput" value="#email#" placeholder="Email Id">   <p class="err" id="er2"></p> 
              </div>
              <div class="form-floating mb-3">
                <input type="text" name="username" id="username" class="form-control" id="floatingInput" value="#username#" placeholder="Username"> <p class="err" id="er3"></p>
              </div>
              <div class="form-floating mb-3">
                <input type="password" name="password" id="password" class="form-control" id="floatingInput" placeholder="Password">  <p class="err" id="er4"> </p>
              </div>
              <div class="form-floating mb-3">
                <input type="password" name="pass2" id="pass2" class="form-control" id="floatingInput" placeholder="Confirm Password"> <p class="err" id="er5"></p>
              </div>
              <span class="err" id="er6">  </span>

              <cfif status eq "false">
                <span class="err"> Email already exists! </span>
              </cfif>
              <div class="d-grid s2">
                <button class="btn btn-primary btn-login text-uppercase fw-bold btn-lg" name="register" type="submit">Register</button>
              </div>
              <hr class="my-4">
              <div class="d-grid mb-2">
                <button class="btn btn-google btn-login text-uppercase fw-bold" type="submit">
                  <img src="http://127.0.0.1:8500/tasks/addressbook/public/images/google-logo.png" alt="Girl in a jacket" width="50" height="50"> Sign in with Google
                </button>
              </div>
              <div class="d-grid ">
                <button class="btn btn-facebook btn-login text-uppercase fw-bold" type="submit">
                  <img src="http://127.0.0.1:8500/tasks/addressbook/public/images/face-logo.png" alt="Girl in a jacket" width="50" height="50">  Sign in with Facebook
                </button>
              </div>
              <div class="d-grid s2">
                  Do You have an account? <a href="index.cfm">Login Here</a>
              </div>
            </form>
        </div>
     </cfoutput>

  </div>
  </div>
</div>

<!-- jQuery -->
<script src="http://127.0.0.1:8500/tasks/addressbook/public/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="http://127.0.0.1:8500/tasks/addressbook/public/jquery/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="http://127.0.0.1:8500/tasks/addressbook/public/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="http://127.0.0.1:8500/tasks/addressbook/public/demo.js"></script>

<script>
  function myFunction(event) {
    var name        = document.getElementById('name').value;
    var email       = document.getElementById('email').value;
    var username    = document.getElementById('username').value;
    var pass1       = document.getElementById('password').value;
    var pass2       = document.getElementById('pass2').value;
    if(name == ""){
        event.preventDefault();   
        document.getElementById('er1').innerHTML = "Please enter name";    
    }
    else{
        document.getElementById('er1').innerHTML = "";
    }
    if(email == ""){
        event.preventDefault();   
        document.getElementById('er2').innerHTML = "please  enter email";    
    }
    else{
        document.getElementById('er2').innerHTML = "";
    }

    if(username == ""){
        event.preventDefault();   
        document.getElementById('er3').innerHTML = "please  enter username";    
    }
    else{
        document.getElementById('er3').innerHTML = "";
    }

    if(pass1 == ""){
        event.preventDefault();   
        document.getElementById('er4').innerHTML = "please  enter password";    
    }
    else{
        document.getElementById('er4').innerHTML = "";
    }

    if(pass2 == ""){
        event.preventDefault();   
        document.getElementById('er5').innerHTML = "please  re-enter password";    
    }
    else{
        document.getElementById('er5').innerHTML = "";
    }

    if(pass1 != pass2){
        event.preventDefault();   
        document.getElementById('er6').innerHTML = "please  doesnot matching";    
    }
    else{
        document.getElementById('er6').innerHTML = "";
    }

    
  }
</script>

</body>
</html>
