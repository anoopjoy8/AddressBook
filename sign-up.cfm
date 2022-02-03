<cfset errorStruct = {}/>
<cfset status      = ""/>
<cfif structKeyExists(form, 'register')> 
    <cfscript> 
      validating            = createObject("component",'components/authentication');
      errorStruct           = validating.validateUsersignup(form.name,form.username,form.email,form.password,form.pass2);
      isEmpty               = StructIsEmpty(errorStruct);
    </cfscript>
    <cfif isEmpty eq "Yes">
      <cfset authentication    = createObject("component",'components/authentication')/>
      <cfset status            = authentication.SignupMethod(form.name,form.username,form.email,form.password,form.pass2)/>
    </cfif>
    <cfif status eq "YES">
        Anoop
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
            <form method="post">
              <div class="form-floating mb-3">
                <input type="text" name="name" class="form-control" id="floatingInput" placeholder="Full Name"> <cfif structKeyExists(errorStruct, 1)> <span class="err">#errorStruct.1#</span> </cfif>
              </div>
              <div class="form-floating mb-3">
                <input type="email" name="email" class="form-control" id="floatingInput" placeholder="Email Id"> <cfif structKeyExists(errorStruct, 2)> <span class="err">#errorStruct.2#</span> </cfif>
              </div>
              <div class="form-floating mb-3">
                <input type="text" name="username" class="form-control" id="floatingInput" placeholder="Username"> <cfif structKeyExists(errorStruct, 3)> <span class="err"> #errorStruct.3# </span></cfif>
              </div>
              <div class="form-floating mb-3">
                <input type="password" name="password" class="form-control" id="floatingInput" placeholder="Password"> <cfif structKeyExists(errorStruct, 4)> <span class="err">#errorStruct.4# </span></cfif>
              </div>
              <div class="form-floating mb-3">
                <input type="password" name="pass2" class="form-control" id="floatingInput" placeholder="Confirm Password"> <cfif structKeyExists(errorStruct, 5)> <span class="err"> #errorStruct.5# </span></cfif>
              </div>
              <cfif structKeyExists(errorStruct, 6)><span class="err"> #errorStruct.6# </span> </cfif>
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

    <cfif IsNull(errorMessage)>
    <cfelse>
        <cfloop array="#errorMessage#" item="x">
          <cfoutput>#x# <br/> </cfoutput>
        </cfloop>
    </cfif>

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
</body>
</html>
