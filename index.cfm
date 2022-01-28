
<cfset errorStructlog = {}/>
<cfset coInfo         = {}/>
<cfset status         = ""/>
<cfif structKeyExists(form, 'submit')> 
  <cfscript> 
      validating            = createObject("component",'components/authentication');
      errorStructlog        = validating.validateUser(form.username,form.pass);
      isEmpty               = StructIsEmpty(errorStructlog);
  </cfscript>
  <cfif isEmpty eq "Yes">
    <cfscript> 
      loging                = createObject("component",'components/authentication');
      status                = loging.loginMethod(form.username,form.pass);
    </cfscript>
    <cfif status eq "true">
        <cflocation url ="http://127.0.0.1:8500/tasks/addressbook/page.cfm">
    </cfif>
  </cfif>
</cfif>

<cfif structKeyExists(url, 'ul')> 
   <cfif url.ul eq "google">
      <cfset loging                = createObject("component",'components/authentication')/>
      <cfset status = loging.googleMethod()/>
      <cfif status eq "true">
          <cflocation url ="http://127.0.0.1:8500/tasks/addressbook/page.cfm">
      </cfif>
   </cfif>
   <cfif url.ul eq "fb">
      <cfset loging                = createObject("component",'components/authentication')/>
      <cfset status                = loging.facebookMethod()/>
   </cfif>
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
            <a href="http://127.0.0.1:8500/tasks/addressbook/index.cfm?ul=google">
             <img src="http://127.0.0.1:8500/tasks/addressbook/public/images/google-logo.png" alt="Girl in a jacket" width="50" height="50"> Sign in with Google 
            </a>
          </div>
          <div class="d-grid ">
            <!--- <a href="http://127.0.0.1:8500/tasks/addressbook/index.cfm?ul=facebook">
                <img src="http://127.0.0.1:8500/tasks/addressbook/public/images/face-logo.png" alt="Girl in a jacket" width="50" height="50">  Sign in with Facebook
              </a> --->

<!--- <a  id="fbLink" href="http://127.0.0.1:8500/tasks/addressbook/index.cfm?ul=fb"> Login with Facebook</a> --->

              <a  id="fbLink" href="javascript:void(0)" onclick="FbLogin()"> Login with Facebook</a>
              <div id="status">
              </div>
              <div id="userData"></div>

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


<script>

  window.fbAsyncInit = function() {
    FB.init({
      appId      : '2784409778518243',
      xfbml      : true,
      version    : 'v12.0'
    });
    FB.AppEvents.logPageView();
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "https://connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));

     function FbLogin() {
            FB.login(function (response) {
                if (response.authResponse) {
                    // Get and display the user profile data
                    getFbUserData();
                } else {
                    document.getElementById('status').innerHTML = 'User cancelled login or did not fully authorize.';
                }
            }, {scope: 'email'});
        }


        // Logout from facebook
        function fbLogout() {
            FB.logout(function() {
                document.getElementById('fbLink').setAttribute("onclick","fbLogin()");
                document.getElementById('fbLink').innerHTML = '<img src="images/fb-login-btn.png"/>';
                document.getElementById('userData').innerHTML = '';
                document.getElementById('status').innerHTML = '<p>You have successfully logout from Facebook.</p>';
            });
        }


  </script>



  <script>     
        function getFbUserData(){
            FB.api('/me', {locale: 'en_US', fields: 'id,first_name,last_name,email,link,gender,locale,picture'},
            function (response) {
                document.getElementById('fbLink').setAttribute("onclick","fbLogout()");
                document.getElementById('fbLink').innerHTML = 'Logout from Facebook';
                document.getElementById('status').innerHTML = '<p>Thanks for logging in, ' + response.first_name + '!</p>';
                document.getElementById('userData').innerHTML = '<h2>Facebook Profile Details</h2><p><img src="'+response.picture.data.url+'"/></p><p><b>FB ID:</b> '+response.id+'</p><p><b>Name:</b> '+response.first_name+' '+response.last_name+'</p><p><b>Email:</b> '+response.email+'</p><p><b>Gender:</b> '+response.gender+'</p><p><b>FB Profile:</b> <a target="_blank" href="'+response.link+'">click to view profile</a></p>';
                            var spanglist = {
                            name: response.first_name,
                            email:response.email};
                     var data = JSON.stringify(userData);

                              const xhttp = new XMLHttpRequest();
                              xhttp.onload = function(){
                                  window.location.href = "page.cfm"
                              }
                              xhttp.open("POST", "authentication.cfc?method=facebookMethod&emailId="+response.email+"&firstName="+response.first_name+"&lastName="+response.last_name, true);
                              xhttp.send();

                                                                                              console.log(spanglist);
                              });
           

            
        }
  </script>

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
