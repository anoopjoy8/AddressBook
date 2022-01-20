<cfset errorStructlog = {}/>
<cfset status         = ""/>
<cfif structKeyExists(form, 'submit')> 
  <cfscript> 
      validating            = createObject("component",'authentication');
      errorStructlog        = validating.validateUser(form.username,form.pass);
      isEmpty               = StructIsEmpty(errorStructlog);
  </cfscript>
  <cfif isEmpty eq "Yes">
    <cfscript> 
      loging                = createObject("component",'authentication');
      status                = loging.loginMethod(form.username,form.pass);
    </cfscript>
    <cfif status eq "true">
        <cflocation url ="http://127.0.0.1:8500/tasks/addressbook/page.cfm">
    </cfif>
  </cfif>
</cfif>

<cfif structKeyExists(url, 'ul')> 
   <cflocation url ="http://127.0.0.1:8500/tasks/addressbook/page.cfm">
</cfif>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="google-signin-client_id" content="1009946409223-o59j27t0k6l9h4h9toop9asmuia42g4e.apps.googleusercontent.com">
  <title>Address Book | Anoop</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <cfinclude template = "header-script.cfm">
</head>
<body>
<cfinclude template = "header.cfm">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<div class="div-center">
<div class="card border-0 shadow rounded-3 my-5 c1">
  <div class="row">
    <div class="card-body bg">
      <i class="fas fa-address-book fa-7x cent"></i> 
    </div>
  <div class="card-body p-4 p-sm-5">
    <h5 class="card-title text-center mb-5">Login</h5>
    <cfoutput>
        <form method="post">
          <div class="form-floating mb-3">
            <input type="text" name="username" class="form-control" id="floatingInput" placeholder="Username/Email"> <cfif structKeyExists(errorStructlog, 1)> <span class="err">#errorStructlog.1#</span> </cfif>
          </div>
          <div class="form-floating mb-3">
            <input type="password" name="pass" class="form-control" id="floatingPassword" placeholder="Password"> <cfif structKeyExists(errorStructlog, 2)> <span class="err">#errorStructlog.2#</span> </cfif>
          </div>
          <cfif status eq "false">
              <span class="err"> Invalid Credentials! </span>
          </cfif>
                  <div class="d-grid s2">
            <button name="submit" class="btn btn-primary btn-login text-uppercase fw-bold btn-lg" type="submit">Sign in</button>
          </div>
          <hr class="my-4">
          <div class="d-grid mb-2">
            <a href="index.cfm?ul=g">
              <img src="http://127.0.0.1:8500/tasks/addressbook/public/images/google-logo.png" alt="Girl in a jacket" width="50" height="50"> Sign in with Google
            </a>
          </div>
          <div class="d-grid ">
            
              <img src="http://127.0.0.1:8500/tasks/addressbook/public/images/face-logo.png" alt="Girl in a jacket" width="50" height="50">  Sign in with Facebook
              <div class="g-signin2" data-onsuccess="onSignIn"></div>
              <data class="data">
              <p> Name </p>
              <p id="name"> </p>
              </div>
           
          </div>

          <div class="d-grid s2">
              Don't have an account? <a href="sign-up.cfm">Register Here</a>
          </div>
        </form>
    </cfoutput>
  </div>

</div>
</div>
</div>


<!-- jQuery -->
<script src="http://127.0.0.1:8500/tasks/addressbook/public/jquery/index.js"></script>
<script src="http://127.0.0.1:8500/tasks/addressbook/public/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="http://127.0.0.1:8500/tasks/addressbook/public/jquery/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="http://127.0.0.1:8500/tasks/addressbook/public/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="http://127.0.0.1:8500/tasks/addressbook/public/demo.js"></script>
</body>
</html>
